import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import '../wallabag/endpoints.dart';
import 'api.dart';
import 'wallabag_api.dart';

part '_g/wallabag.g.dart';

class WallabagClient extends ApiClient
    with WallabagClientEndpoints, WallabagMethods {
  static String tokenEndpointPath = '/oauth/v2/token';

  WallabagClient(
    this._credsAdapter, {
    super.userAgent,
    super.selfSignedHost,
    super.enableHttpLogs,
  });

  final UpdatableWallabagCredentialsAdapter _credsAdapter;

  Future<WallabagCredentials> _getCredentials() async {
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
      if (userAgent != null) HttpHeaders.userAgentHeader: userAgent!,
    });
    if (!request.url.path.endsWith(tokenEndpointPath)) {
      if (credentials.token?.isExpired ?? true) {
        await refreshToken();
        credentials = await _getCredentials();
      }
      final accessToken = credentials.token!.accessToken;
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
      request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    }
    final stopwatch = Stopwatch()..start();
    logRequest(request as http.Request);
    return innerClient
        .send(request)
        .then((response) {
          logger.info(
            '${request.method} ${request.url} ${response.statusCode} (${stopwatch.elapsed.inMilliseconds} ms)',
          );
          return response;
        })
        .onError((e, _) => throw ServerError.fromException(e as Exception));
  }

  @override
  Future<Uri> buildUri(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) async {
    final credentials = await _getCredentials();
    return credentials.server.replace(
      path: credentials.server.path + path,
      queryParameters: queryParameters,
    );
  }

  Future<http.Response> authenticate(Map<String, String> grantData) async {
    logger.info(
      'authentication attempt (grant_type: ${grantData['grant_type']})',
    );
    final credentials = await _getCredentials();
    final payload = {
      'client_id': credentials.clientId,
      'client_secret': credentials.clientSecret,
      ...grantData,
    };
    final response = await post(
      await buildUri(tokenEndpointPath),
      headers: {if (userAgent != null) 'User-Agent': userAgent!},
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

@JsonSerializable()
class WallabagCredentials {
  WallabagCredentials(
    this.server,
    this.clientId,
    this.clientSecret, {
    this.token,
  });

  final Uri server;
  final String clientId;
  final String clientSecret;
  OAuthToken? token;

  factory WallabagCredentials.fromJson(Map<String, dynamic> json) =>
      _$WallabagCredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$WallabagCredentialsToJson(this);
}

@JsonSerializable()
class OAuthToken {
  OAuthToken(this.accessToken, this.expiresAt, this.refreshToken);

  final String accessToken;
  final int expiresAt;
  final String refreshToken;

  DateTime get expirationDateTime =>
      DateTime.fromMillisecondsSinceEpoch(expiresAt * 1000);
  bool get isExpired => expirationDateTime.isBefore(DateTime.now());

  factory OAuthToken.fromJson(Map<String, dynamic> json) =>
      _$OAuthTokenFromJson(json);
  Map<String, dynamic> toJson() => _$OAuthTokenToJson(this);
}

abstract class UpdatableWallabagCredentialsAdapter {
  Future<WallabagCredentials?> read();
  Future<void> write(WallabagCredentials credentials);
}

class InMemoryCredentials extends UpdatableWallabagCredentialsAdapter {
  InMemoryCredentials(this._credentials);

  WallabagCredentials? _credentials;
  WallabagCredentials? get credentials => _credentials;

  @override
  Future<WallabagCredentials?> read() async => _credentials;

  @override
  Future<void> write(WallabagCredentials credentials) async {
    _credentials = credentials;
  }
}
