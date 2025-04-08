import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import '../wallabag/client.dart';

part 'freon.g.dart';

@JsonSerializable()
class FreonCredentials {
  const FreonCredentials(this.server, this.apiToken);

  final Uri server;
  final String apiToken;

  factory FreonCredentials.fromJson(Map<String, dynamic> json) =>
      _$FreonCredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$FreonCredentialsToJson(this);
}

class FreonWallabagClient extends WallabagClient {
  FreonWallabagClient(
    this._credentials, {
    super.userAgent,
    super.selfSignedHost,
  });

  final FreonCredentials _credentials;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers.addAll({
      HttpHeaders.authorizationHeader: _credentials.apiToken,
      HttpHeaders.contentTypeHeader: 'application/json',
      if (userAgent != null) HttpHeaders.userAgentHeader: userAgent!,
    });
    final stopwatch = Stopwatch()..start();
    try {
      final response = await innerClient.send(request);
      logRequest(request as http.Request);
      logger.info(
          '${request.method} ${request.url} ${response.statusCode} (${stopwatch.elapsed.inMilliseconds} ms)');
      return response;
    } on Exception catch (e) {
      throw ServerError.fromException(e);
    }
  }

  @override
  Future<Uri> buildUri(String path,
      [Map<String, dynamic>? queryParameters]) async {
    return _credentials.server.replace(
      path: '${_credentials.server.path}/wallabag$path',
      queryParameters: queryParameters,
    );
  }
}

class FreonClient {
  FreonClient(FreonCredentials credentials)
      : wallabag = FreonWallabagClient(credentials);

  FreonWallabagClient wallabag;
}
