import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http/retry.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:universal_platform/universal_platform.dart';

import 'api_methods.dart';

part '_g/api.g.dart';

void throwOnError(http.Response response, {List<int> expected = const [200]}) {
  if (!expected.contains(response.statusCode)) {
    throw ServerError.fromResponse(response);
  }
}

class ServerError implements Exception {
  static const messageMaybeKeys = ['error_description', 'error'];

  const ServerError(
    this.message, {
    this.source,
    this.response,
    this.manuallyInvalidated = false,
  });

  final String message;
  final Exception? source;
  final http.Response? response;
  final bool manuallyInvalidated;

  @override
  String toString() {
    final statusPart = response != null ? ' (${response!.statusCode})' : '';
    var str = 'ServerError$statusPart: $message';
    if (source != null) str += ': $source';
    if (response != null) str += ': ${response!.body}';
    return str;
  }

  factory ServerError.fromResponse(http.Response response) {
    var message = response.body;
    if (message.length > 100) message = '${message.substring(0, 100)}...';
    try {
      final json = jsonDecode(response.body);
      for (final key in messageMaybeKeys) {
        if (json.containsKey(key)) {
          message = json[key];
          break;
        }
      }
    } catch (_) {}
    return ServerError(message, response: response);
  }
  factory ServerError.fromException(Exception e, {http.Response? response}) =>
      ServerError('unknown error', source: e, response: response);

  bool get isInvalidTokenError {
    if (manuallyInvalidated) return true;

    if (response?.body == null) return false;
    try {
      // wallabag access tokens expired after 14 days (default) it implies a
      // username/password re-login.
      // The alternative would be to store the credentials, but no.
      final json = jsonDecode(response!.body);
      final description = json['error_description'] as String;
      // TODO IIRC the status code are different for the 2 tokens and would be a
      // better way to check the state. I need an expired device to validated that.
      return json['error'] == 'invalid_grant' &&
          description.toLowerCase().contains('refresh token');
    } catch (_) {
      return false;
    }
  }
}

typedef Decoder<T> = T Function(Map<String, dynamic>);

T safeDecode<T>(http.Response response, Decoder<T> decoder) {
  try {
    final json = jsonDecode(response.body);
    return decoder(json);
  } catch (source) {
    throw switch (source) {
      ServerError e => e,
      Exception e => ServerError.fromException(e, response: response),
      _ => ServerError.fromException(
        Exception(source.toString()),
        response: response,
      ),
    };
  }
}

http.Client newClient({String? selfSignedHost}) {
  if (selfSignedHost == null) {
    return http.Client();
  }
  return IOClient(
    HttpClient()
      ..badCertificateCallback = (cert, host, port) => host == selfSignedHost,
  );
}

abstract class ApiClient extends http.BaseClient with ApiMethods {
  static final _log = Logger('apiclient');

  ApiClient({
    String? userAgent,
    String? selfSignedHost,
    this.enableHttpLogs = false,
  }) : _userAgent = userAgent,
       _selfSignedHost = selfSignedHost;

  final String? _userAgent;
  final String? _selfSignedHost;
  final bool enableHttpLogs;
  http.Client? _inner;

  http.Client get innerClient {
    _inner ??= RetryClient(newClient(selfSignedHost: _selfSignedHost));
    return _inner!;
  }

  Logger get logger => _log;
  String? get userAgent => UniversalPlatform.isWeb ? null : _userAgent;

  Future<Uri> buildUri(String path, [Map<String, dynamic>? queryParameters]);

  void logRequest(http.Request request) {
    if (!enableHttpLogs) return;

    final lines =
        ['>' * 80, '${request.method} ${request.url}'] +
        request.headers.entries.map((e) => 'H ${e.key}=${e.value}').toList() +
        ['-' * 80, request.body, '>' * 80];

    logger.info('outbound request:\n${lines.join('\n')}');
  }
}

@JsonSerializable()
class TokenBearerCredentials {
  const TokenBearerCredentials(this.server, this.apiToken);

  final Uri server;
  final String apiToken;

  factory TokenBearerCredentials.fromJson(Map<String, dynamic> json) =>
      _$TokenBearerCredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$TokenBearerCredentialsToJson(this);
}

abstract class TokenBearerClient extends ApiClient {
  TokenBearerClient(
    this._credentials, {
    super.userAgent,
    super.selfSignedHost,
    super.enableHttpLogs,
  });

  final TokenBearerCredentials _credentials;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer ${_credentials.apiToken}',
      HttpHeaders.contentTypeHeader: 'application/json',
      if (userAgent != null) HttpHeaders.userAgentHeader: userAgent!,
    });
    final stopwatch = Stopwatch()..start();
    try {
      final response = await innerClient.send(request);
      logRequest(request as http.Request);
      logger.info(
        '${request.method} ${request.url} ${response.statusCode} (${stopwatch.elapsed.inMilliseconds} ms)',
      );
      return response;
    } on Exception catch (e) {
      throw ServerError.fromException(e);
    }
  }

  @override
  Future<Uri> buildUri(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) async {
    return _credentials.server.replace(
      path: _credentials.server.path + path,
      queryParameters: queryParameters,
    );
  }
}
