import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import 'client.dart';
import 'credentials.dart';

export 'models/annotation.dart' show WallabagAnnotation;
export 'models/entry.dart' show WallabagEntry;
export 'models/tag.dart' show WallabagTag;

part 'wallabag.g.dart';

class WallabagNativeClient extends WallabagClient {
  static String tokenEndpointPath = '/oauth/v2/token';

  WallabagNativeClient(this._credsAdapter, {super.selfSignedHost});

  final UpdatableCredentialsAdapter _credsAdapter;

  Future<Credentials> _getCredentials() async {
    final credentials = await _credsAdapter.read();
    if (credentials == null) {
      throw const ServerError('No credentials found');
    }
    return credentials;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // loaded every time to handle desync from external extensions
    var credentials = await _getCredentials();

    request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      if (userAgent != null) HttpHeaders.userAgentHeader: userAgent!,
    });
    if (!request.url.path.endsWith(tokenEndpointPath)) {
      if (credentials.token?.isExpired ?? true) {
        await refreshToken();
        credentials = await _getCredentials();
      }
      final accessToken = credentials.token!.accessToken;
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }
    final stopwatch = Stopwatch()..start();
    logRequest(request as http.Request);
    return innerClient.send(request).then((response) {
      logger.info(
          '${request.method} ${request.url} ${response.statusCode} (${stopwatch.elapsed.inMilliseconds} ms)');
      return response;
    }).onError((e, _) => throw ServerError.fromException(e as Exception));
  }

  @override
  Future<Uri> buildUri(String path,
      [Map<String, dynamic>? queryParameters]) async {
    final credentials = await _getCredentials();
    return Uri.https(
      credentials.server.authority,
      credentials.server.path + path,
      queryParameters,
    );
  }

  Future<http.Response> authenticate(Map<String, String> grantData) async {
    logger.info(
        'authentication attempt (grant_type: ${grantData['grant_type']})');
    final credentials = await _getCredentials();
    final payload = {
      'client_id': credentials.clientId,
      'client_secret': credentials.clientSecret,
      ...grantData,
    };
    final response = await post(
      await buildUri(tokenEndpointPath),
      headers: {
        if (userAgent != null) 'User-Agent': userAgent!,
      },
      body: payload,
    );
    throwOnError(response);

    final tokenData = safeDecode(response, OAuthTokenBody.fromJson);
    credentials.token = OAuthToken(
      tokenData.accessToken,
      DateTime.now().millisecondsSinceEpoch ~/ 1000 + tokenData.expiresIn,
      tokenData.refreshToken,
    );
    _credsAdapter.write(credentials);

    return response;
  }

  Future<http.Response> fetchToken(String username, String password) {
    return authenticate({
      'grant_type': 'password',
      'username': username,
      'password': password,
    });
  }

  Future<http.Response> refreshToken() async {
    final credentials = await _getCredentials();
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
