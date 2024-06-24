import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:json_annotation/json_annotation.dart';

import 'client.dart';
import 'credentials.dart';

export 'models/annotation.dart' show WallabagAnnotation;
export 'models/entry.dart' show WallabagEntry;
export 'models/tag.dart' show WallabagTag;

part 'wallabag.g.dart';

class WallabagNativeClient extends WallabagClient {
  static String tokenEndpointPath = '/oauth/v2/token';

  static Future<WallabagNativeClient> build({
    Credentials? credentials,
    bool? autoSyncCredentials,
  }) async {
    late final CredentialsManager credsManager;
    if (autoSyncCredentials != null) {
      credsManager = CredentialsManager(autoSync: autoSyncCredentials);
    } else {
      credsManager = CredentialsManager();
    }
    await credsManager.init(initial: credentials);
    return WallabagNativeClient(credsManager);
  }

  WallabagNativeClient(this._credsManager);

  final http.Client _inner = RetryClient(http.Client());
  final CredentialsManager _credsManager;

  Credentials get credentials => _credsManager.credentials!;
  bool get canRefreshToken => _credsManager.canRefreshToken;
  bool get tokenIsExpired => _credsManager.tokenIsExpired;

  @override
  bool get isReady => canRefreshToken;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    _credsManager.load(); // handle desync from external extensions
    request.headers.addAll({
      'Content-Type': 'application/json',
      if (userAgent != null) 'User-Agent': userAgent!,
    });
    if (!request.url.path.endsWith(tokenEndpointPath)) {
      if (_credsManager.canRefreshToken && tokenIsExpired) await refreshToken();
      final accessToken = credentials.token!.accessToken;
      request.headers['Authorization'] = 'Bearer $accessToken';
    }
    final stopwatch = Stopwatch()..start();
    return _inner.send(request).then((response) {
      logger.info(
          '${request.method} ${request.url} ${response.statusCode} (${stopwatch.elapsed.inMilliseconds} ms)');
      return response;
    }).onError((e, _) => throw ServerError.fromException(e as Exception));
  }

  @override
  Uri buildUri(String path, [Map<String, dynamic>? queryParameters]) {
    return Uri.https(
      credentials.server.authority,
      credentials.server.path + path,
      queryParameters,
    );
  }

  Future<http.Response> authenticate(Map<String, String> grantData) async {
    logger.info(
        'authentication attempt (grant_type: ${grantData['grant_type']})');
    final payload = {
      'client_id': credentials.clientId,
      'client_secret': credentials.clientSecret,
      ...grantData,
    };
    final response = await post(
      buildUri(tokenEndpointPath),
      headers: {
        if (userAgent != null) 'User-Agent': userAgent!,
      },
      body: payload,
    );
    throwOnError(response);

    final tokenData = safeDecode(response, OAuthTokenBody.fromJson);
    _credsManager.token = OAuthToken(
      tokenData.accessToken,
      DateTime.now().millisecondsSinceEpoch ~/ 1000 + tokenData.expiresIn,
      tokenData.refreshToken,
    );

    return response;
  }

  Future<void> resetTokenData() async {
    _credsManager.token = null;
  }

  Future<void> resetSession() => _credsManager.clear();

  Future<http.Response> fetchToken(String username, String password) {
    return authenticate({
      'grant_type': 'password',
      'username': username,
      'password': password,
    });
  }

  Future<http.Response> refreshToken() {
    return authenticate({
      'grant_type': 'refresh_token',
      'refresh_token': credentials.token!.refreshToken,
    });
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class OAuthTokenBody {
  OAuthTokenBody(this.accessToken, this.expiresIn, this.refreshToken);

  final String accessToken;
  final int expiresIn;
  final String refreshToken;

  factory OAuthTokenBody.fromJson(Map<String, dynamic> json) =>
      _$OAuthTokenBodyFromJson(json);
}

@Deprecated('use ServerInstance instead')
class WallabagInstance {
  static WallabagNativeClient? _instance;

  static Future<WallabagNativeClient> init({Credentials? credentials}) async {
    _instance = await WallabagNativeClient.build(credentials: credentials);
    return _instance!;
  }

  static WallabagNativeClient get() {
    assert(_instance != null);
    return _instance!;
  }

  static bool get isReady => _instance != null && _instance!.canRefreshToken;
}
