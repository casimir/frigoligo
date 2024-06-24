import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

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

const credentialsKey = '${kDebugMode ? 'debug.' : ''}freon.credentials';

class FreonCredentialsManager {
  const FreonCredentialsManager(this._prefs);

  final SharedPreferences _prefs;

  FreonCredentials? get credentials {
    final raw = _prefs.getString(credentialsKey);
    if (raw == null) return null;
    return FreonCredentials.fromJson(jsonDecode(raw));
  }

  set credentials(FreonCredentials? value) => _save(value);

  Future<void> _save(FreonCredentials? value) async {
    if (value == null) return;

    final encoded = jsonEncode(value.toJson());
    _prefs.setString(credentialsKey, encoded);
    if (UniversalPlatform.isIOS) {
      await SharedPreferenceAppGroup.setString(credentialsKey, encoded);
    }
  }
}

class FreonWallabagClient extends WallabagClient {
  FreonWallabagClient(this._credentials);

  final http.Client _inner = RetryClient(http.Client());
  final FreonCredentials _credentials;

  FreonCredentials get credentials => _credentials;

  @override
  bool get isReady => true;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers.addAll({
      'Authorization': _credentials.apiToken,
      'Content-Type': 'application/json',
      if (userAgent != null) 'User-Agent': userAgent!,
    });
    final stopwatch = Stopwatch()..start();
    try {
      final response = await _inner.send(request);
      logger.info(
          '${request.method} ${request.url} ${response.statusCode} (${stopwatch.elapsed.inMilliseconds} ms)');
      return response;
    } on Exception catch (e) {
      throw ServerError.fromException(e);
    }
  }

  @override
  Uri buildUri(String path, [Map<String, dynamic>? queryParameters]) {
    return Uri.https(
      _credentials.server.authority,
      '${_credentials.server.path}/wallabag$path',
      queryParameters,
    );
  }
}

class FreonClient {
  FreonClient(FreonCredentials credentials)
      : wallabag = FreonWallabagClient(credentials);

  FreonWallabagClient wallabag;
}
