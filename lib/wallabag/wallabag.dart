import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'models/annotation.dart' show WallabagAnnotation;
import 'models/entry.dart';
export 'models/entry.dart' show WallabagEntry;
import 'models/info.dart';
export 'models/tag.dart' show WallabagTag;

part 'wallabag.g.dart';

final _log = Logger('wallabag.client');

const wallabagConnectionDataKey = 'wallabag.connectionData';

void throwOnError(http.Response response, {List<int> expected = const [200]}) {
  if (!expected.contains(response.statusCode)) {
    throw WallabagError.fromResponse(response);
  }
}

class WallabagError implements Exception {
  const WallabagError(this.message, {this.source});

  final String message;
  final Exception? source;

  @override
  String toString() {
    var str = 'WallabagError: $message';
    if (source != null) {
      str += ': $source';
    }
    return str;
  }

  factory WallabagError.fromResponse(http.Response response) =>
      WallabagError('${response.statusCode} > ${response.body}');
  factory WallabagError.fromException(Exception e) =>
      WallabagError('unknown error', source: e);
}

Future<String> _buildUserAgent() async {
  var info = await PackageInfo.fromPlatform();
  return '${info.appName}/${info.version}+${info.buildNumber}';
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
  static String tokenDataKey = 'tokenData';

  static Future<WallabagClient> build(WallabagConnectionData data) async =>
      WallabagClient._(data, await _buildUserAgent(), await _loadTokenData());

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
    var response = await http.post(_buildUri(tokenEnpointPath), body: payload);
    throwOnError(response);

    var tokenData = OAuthToken.fromJson(jsonDecode(response.body));
    _tokenData = tokenData;
    _persistTokenData();

    return response;
  }

  static Future<OAuthToken?> _loadTokenData() {
    return SharedPreferences.getInstance().then((prefs) {
      var rawTokenData = prefs.getString('tokenData');
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

  Future<http.Response> fetchToken(username, password) {
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

  Future<(WallabagPaginatedEntries, http.Response)> getEntries({
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
    var response = await get(_buildUri(
      '/api/entries.json',
      params.map((key, value) => MapEntry(key, value.toString())),
    ));
    throwOnError(response);
    var pageData = WallabagPaginatedEntries.fromJson(jsonDecode(response.body));
    return (pageData, response);
  }

  Future<(WallabagEntry, http.Response)> getEntry(int id) async {
    var response = await get(_buildUri('/api/entries/$id.json'));
    throwOnError(response);
    return (WallabagEntry.fromJson(jsonDecode(response.body)), response);
  }

  Future<(WallabagEntry, http.Response)> createEntry(
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
    return (WallabagEntry.fromJson(jsonDecode(response.body)), response);
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
    var response = await patch(
      _buildUri('/api/entries/$id.json'),
      body: params.map((key, value) => MapEntry(key, value.toString())),
    );
    throwOnError(response);
    return response;
  }

  Future<http.Response> deleteEntry(int id) async {
    var response = await delete(_buildUri('/api/entries/$id.json'));
    throwOnError(response);
    return response;
  }

  Future<(WallabagInfo, http.Response)> getInfo() async {
    var response = await get(_buildUri('/api/info.json'));
    throwOnError(response);
    return (WallabagInfo.fromJson(jsonDecode(response.body)), response);
  }

  // higher level methods

  Future<int> fetchTotalEntriesCount() async {
    var (data, response) =
        await getEntries(perPage: 1, detail: DetailValue.metadata);
    throwOnError(response);
    return data.total;
  }

  Stream<(List<WallabagEntry>, http.Response)> fetchAllEntries({
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
      var (pageData, response) = await getEntries(
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
      lastPage = pageData.pages;
      _log.info('fetched entries (page $pageIndex of $lastPage)');
      onProgress?.call(pageIndex / lastPage);
      pageIndex++;
      yield (pageData.embedded.items, response);
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

  static Future<WallabagClient?> initWith(WallabagConnectionData data) async {
    await SharedPreferences.getInstance().then((prefs) =>
        prefs.setString(wallabagConnectionDataKey, jsonEncode(data.toJson())));
    return init();
  }

  static WallabagClient get() {
    assert(_instance != null);
    return _instance!;
  }

  static bool get isReady => _instance != null && _instance!.canRefreshToken;
}
