import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'models/annotation.dart' show WallabagAnnotation;
import 'models/entry.dart';
export 'models/entry.dart' show WallabagEntry;
import 'models/info.dart';
export 'models/tag.dart' show WallabagTag;
import 'utils.dart';

part 'wallabag.g.dart';

final _log = Logger('wallabag.client');

const wallabagConnectionDataKey =
    '${kDebugMode ? 'debug.' : ''}wallabag.connectionData';

void throwOnError(http.Response response, {List<int> expected = const [200]}) {
  if (!expected.contains(response.statusCode)) {
    throw WallabagError.fromResponse(response);
  }
}

class WallabagError implements Exception {
  const WallabagError(this.message, {this.source, this.response});

  final String message;
  final Exception? source;
  final http.Response? response;

  @override
  String toString() {
    final statusPart = response != null ? ' (${response!.statusCode})' : '';
    var str = 'WallabagError$statusPart: $message';
    if (source != null) str += ': $source';
    if (response != null) str += ': ${response!.body}';
    return str;
  }

  factory WallabagError.fromResponse(http.Response response) {
    var message = response.body;
    if (message.length > 100) message = '${message.substring(0, 100)}...';
    try {
      final json = jsonDecode(response.body);
      message = json['error_description'] ?? json['error'];
    } catch (_) {}
    return WallabagError(message, response: response);
  }
  factory WallabagError.fromException(Exception e, {http.Response? response}) =>
      WallabagError('unknown error', source: e, response: response);
}

typedef Decoder<T> = T Function(Map<String, dynamic>);

T safeDecode<T>(http.Response response, Decoder<T> decoder) {
  try {
    final json = jsonDecode(response.body);
    return decoder(json);
  } catch (source) {
    throw switch (source.runtimeType) {
      WallabagError => source as WallabagError,
      Exception =>
        WallabagError.fromException(source as Exception, response: response),
      _ => WallabagError.fromException(Exception(source.toString()),
          response: response),
    };
  }
}

@JsonSerializable()
class WallabagConnectionData {
  const WallabagConnectionData(this.server, this.clientId, this.clientSecret);

  final String server;
  final String clientId;
  final String clientSecret;

  factory WallabagConnectionData.fromJson(Map<String, dynamic> json) =>
      _$WallabagConnectionDataFromJson(json);
  Map<String, dynamic> toJson() => _$WallabagConnectionDataToJson(this);
}

class WallabagClient extends http.BaseClient {
  static String tokenEnpointPath = '/oauth/v2/token';
  static String tokenDataKey = '${kDebugMode ? 'debug.' : ''}tokenData';

  static Future<WallabagClient> build(WallabagConnectionData data) async =>
      WallabagClient._(data, await buildUserAgent(), await _loadTokenData());

  WallabagClient._(this.connectionData, this.userAgent, this._tokenData);

  final http.Client _inner = RetryClient(http.Client());
  final WallabagConnectionData connectionData;
  OAuthToken? _tokenData;
  final String? userAgent;

  OAuthToken? get tokenData => _tokenData;
  bool get canRefreshToken => _tokenData != null;
  bool get tokenIsExpired => _tokenData!.expiresIn.isBefore(DateTime.now());

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (userAgent != null) request.headers['user-agent'] = userAgent!;
    if (request.url.path != tokenEnpointPath) {
      if (canRefreshToken && tokenIsExpired) await refreshToken();
      request.headers['Authorization'] = 'Bearer ${_tokenData!.accessToken}';
    }
    final stopwatch = Stopwatch()..start();
    return _inner.send(request).then((response) {
      _log.info(
          '${request.method} ${request.url} ${response.statusCode} (${stopwatch.elapsed.inMilliseconds} ms)');
      return response;
    }).onError((e, _) => throw WallabagError.fromException(e as Exception));
  }

  Uri _buildUri(String path, [Map<String, dynamic>? queryParameters]) =>
      Uri.https(connectionData.server, path, queryParameters);

  Future<http.Response> authenticate(Map<String, String> grantData) async {
    _log.info(
        'authentication attempt (grant_type: ${grantData['grant_type']})');
    var payload = {
      'client_id': connectionData.clientId,
      'client_secret': connectionData.clientSecret,
      ...grantData,
    };
    final response = await http.post(
      _buildUri(tokenEnpointPath),
      headers: {'user-agent': await buildUserAgent()},
      body: payload,
    );
    throwOnError(response);

    final tokenData = safeDecode(response, OAuthToken.fromJson);
    _tokenData = tokenData;
    _persistTokenData();

    return response;
  }

  static Future<OAuthToken?> _loadTokenData() {
    return SharedPreferences.getInstance().then((prefs) {
      final rawTokenData = prefs.getString(tokenDataKey);
      if (rawTokenData == null) return null;
      return OAuthToken.fromJson(jsonDecode(rawTokenData));
    });
  }

  Future<void> _persistTokenData() {
    return SharedPreferences.getInstance().then((prefs) {
      prefs.setString(tokenDataKey, jsonEncode(_tokenData!));
    });
  }

  Future<void> resetTokenData() {
    _tokenData = null;
    return SharedPreferences.getInstance().then((prefs) {
      prefs.remove(tokenDataKey);
    });
  }

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
      'refresh_token': _tokenData!.refreshToken,
    });
  }

  Future<WallabagPaginatedEntries> getEntries({
    int? archive,
    int? starred,
    SortValue? sort,
    SortOrder? order,
    int? page,
    int? perPage,
    String? tags, // urlencoded, comma-separated list of tags
    int? since, // timestamp for entries updates
    int? public,
    DetailValue? detail, // include the content if 'full'
    String? domainName,
  }) async {
    var params = {
      'archive': archive,
      'starred': starred,
      'sort': sort?.name,
      'order': order?.name,
      'page': page,
      'perPage': perPage,
      'tags': tags,
      'since': since,
      'public': public,
      'detail': detail?.name,
      'domain_name': domainName,
    }..removeWhere((_, value) => value == null);
    final response = await get(_buildUri(
      '/api/entries.json',
      params.map((key, value) => MapEntry(key, value.toString())),
    ));
    throwOnError(response);
    return safeDecode(response, WallabagPaginatedEntries.fromJson);
  }

  Future<WallabagEntry> getEntry(int id) async {
    final response = await get(_buildUri('/api/entries/$id.json'));
    throwOnError(response);
    return safeDecode(response, WallabagEntry.fromJson);
  }

  Future<WallabagEntry> createEntry(
    String url, {
    String? title,
    List<String>? tags,
    bool? archive,
    bool? starred,
    String? content,
    String? language,
    String? previewPicture,
    DateTime? publishedAt,
    List<String>? authors,
    bool? public,
    String? originUrl,
  }) async {
    final params = {
      'url': url,
      if (title != null) 'title': title,
      if (tags != null) 'tags': tags.join(','),
      if (archive != null) 'archive': archive ? 1 : 0,
      if (starred != null) 'starred': starred ? 1 : 0,
      if (content != null) 'content': content,
      if (language != null) 'language': language,
      if (previewPicture != null) 'preview_picture': previewPicture,
      if (publishedAt != null) 'published_at': publishedAt.toIso8601String(),
      if (authors != null) 'authors': authors.join(','),
      if (public != null) 'public': public ? 1 : 0,
      if (originUrl != null) 'origin_url': originUrl,
    };
    final response = await post(
      _buildUri('/api/entries.json'),
      body: params.map((key, value) => MapEntry(key, value.toString())),
    );
    throwOnError(response);
    return safeDecode(response, WallabagEntry.fromJson);
  }

  Future<http.Response> patchEntry(
    int id, {
    bool? archive,
    bool? starred,
  }) async {
    var params = {
      if (archive != null) 'archive': archive ? 1 : 0,
      if (starred != null) 'starred': starred ? 1 : 0,
    };
    final response = await patch(
      _buildUri('/api/entries/$id.json'),
      body: params.map((key, value) => MapEntry(key, value.toString())),
    );
    throwOnError(response);
    return response;
  }

  Future<http.Response> deleteEntry(int id) async {
    final response = await delete(_buildUri('/api/entries/$id.json'));
    throwOnError(response);
    return response;
  }

  Future<WallabagInfo> getInfo() async {
    final response = await get(_buildUri('/api/info.json'));
    throwOnError(response);
    return safeDecode(response, WallabagInfo.fromJson);
  }

  // higher level methods

  Future<int> fetchTotalEntriesCount() async {
    var data = await getEntries(perPage: 1, detail: DetailValue.metadata);
    return data.total;
  }

  Stream<(List<WallabagEntry>, WallabagError?)> fetchAllEntries({
    int? archive,
    int? starred,
    SortValue? sort,
    SortOrder? order,
    int page = 1,
    int? perPage,
    String? tags, // urlencoded, comma-separated list of tags
    int? since, // timestamp for entries updates
    int? public,
    DetailValue? detail, // include the content if 'full'
    String? domainName,
    Function(float)? onProgress,
  }) async* {
    var pageIndex = page;
    var lastPage = pageIndex + 1; // start with +1 just to start the loop
    onProgress?.call(0);
    while (pageIndex <= lastPage) {
      late WallabagPaginatedEntries pageData;
      try {
        pageData = await getEntries(
          archive: archive,
          starred: starred,
          sort: sort,
          order: order,
          page: pageIndex,
          perPage: perPage,
          tags: tags,
          since: since,
          public: public,
          detail: detail,
          domainName: domainName,
        );
      } catch (source, st) {
        final e = switch (source.runtimeType) {
          WallabagError => source as WallabagError,
          Exception => WallabagError.fromException(source as Exception),
          _ => WallabagError.fromException(Exception(source.toString())),
        };
        _log.severe(
            'error fetching entries (page $pageIndex)', source.toString(), st);
        yield ([], e);
        return;
      }
      lastPage = pageData.pages;
      _log.info('fetched entries (page $pageIndex of $lastPage)');
      onProgress?.call(pageIndex / lastPage);
      pageIndex++;
      yield (pageData.embedded.items, null);
    }
  }
}

DateTime secondsOffsetOrTimestamp2Datetime(value) {
  if (value is int) {
    return DateTime.now().add(Duration(seconds: value));
  } else {
    return DateTime.parse(value);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class OAuthToken {
  OAuthToken(this.accessToken, this.expiresIn, this.refreshToken);

  final String accessToken;
  @JsonKey(fromJson: secondsOffsetOrTimestamp2Datetime)
  final DateTime expiresIn;
  final String refreshToken;

  factory OAuthToken.fromJson(Map<String, dynamic> json) =>
      _$OAuthTokenFromJson(json);
  Map<String, dynamic> toJson() => _$OAuthTokenToJson(this);
}

enum SortValue {
  created,
  updated,
  archived,
}

enum SortOrder {
  asc,
  desc,
}

enum DetailValue {
  metadata,
  full,
}

@JsonSerializable(createToJson: false)
class WallabagPaginatedEntries {
  WallabagPaginatedEntries(
    this.page,
    this.limit,
    this.pages,
    this.total,
    this.embedded,
  );

  final int page;
  final int limit;
  final int pages;
  final int total;
  @JsonKey(name: '_embedded')
  final WallabagEmbeddedEntries embedded;

  factory WallabagPaginatedEntries.fromJson(Map<String, dynamic> json) =>
      _$WallabagPaginatedEntriesFromJson(json);
}

@JsonSerializable(createToJson: false)
class WallabagEmbeddedEntries {
  WallabagEmbeddedEntries(this.items);

  final List<WallabagEntry> items;

  factory WallabagEmbeddedEntries.fromJson(Map<String, dynamic> json) =>
      _$WallabagEmbeddedEntriesFromJson(json);
}

class WallabagInstance {
  static WallabagClient? _instance;

  static Future<WallabagClient?> init() async {
    String? rawData = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString(wallabagConnectionDataKey));
    if (rawData != null) {
      var data = WallabagConnectionData.fromJson(jsonDecode(rawData));
      _instance = await WallabagClient.build(data);
    } else {
      _log.info('could not find existing connection data');
    }
    return _instance;
  }

  static Future<WallabagClient> initWith(WallabagConnectionData data) async {
    await SharedPreferences.getInstance().then((prefs) =>
        prefs.setString(wallabagConnectionDataKey, jsonEncode(data.toJson())));
    final client = await init();
    return client!;
  }

  static WallabagClient get() {
    assert(_instance != null);
    return _instance!;
  }

  static bool get isReady => _instance != null && _instance!.canRefreshToken;
}
