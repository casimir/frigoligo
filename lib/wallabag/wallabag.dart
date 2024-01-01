import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

import 'credentials.dart';
import 'models/entry.dart';
import 'models/info.dart';
import 'utils.dart';

export 'models/annotation.dart' show WallabagAnnotation;
export 'models/entry.dart' show WallabagEntry;
export 'models/tag.dart' show WallabagTag;

part 'wallabag.g.dart';

final _log = Logger('wallabag.client');

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

  bool get isInvalidTokenError {
    if (response?.body == null) return false;
    try {
      final json = jsonDecode(response!.body);
      return json['error'] == 'invalid_grant';
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
      WallabagError e => e,
      Exception e => WallabagError.fromException(e, response: response),
      _ => WallabagError.fromException(Exception(source.toString()),
          response: response),
    };
  }
}

class WallabagClient extends http.BaseClient {
  static String tokenEnpointPath = '/oauth/v2/token';

  static Future<WallabagClient> build({
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
    return WallabagClient._(credsManager, await buildUserAgent());
  }

  WallabagClient._(this._credsManager, this.userAgent);

  final http.Client _inner = RetryClient(http.Client());
  final CredentialsManager _credsManager;
  final String? userAgent;

  Credentials get credentials => _credsManager.credentials!;
  bool get canRefreshToken => _credsManager.canRefreshToken;
  bool get tokenIsExpired => _credsManager.tokenIsExpired;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    _credsManager.load(); // handle desync from external extensions
    if (userAgent != null) request.headers['user-agent'] = userAgent!;
    if (!request.url.path.endsWith(tokenEnpointPath)) {
      if (canRefreshToken && tokenIsExpired) await refreshToken();
      final accessToken = credentials.token!.accessToken;
      request.headers['Authorization'] = 'Bearer $accessToken';
    }
    final stopwatch = Stopwatch()..start();
    return _inner.send(request).then((response) {
      _log.info(
          '${request.method} ${request.url} ${response.statusCode} (${stopwatch.elapsed.inMilliseconds} ms)');
      return response;
    }).onError((e, _) => throw WallabagError.fromException(e as Exception));
  }

  Uri _buildUri(String path, [Map<String, dynamic>? queryParameters]) {
    return Uri.https(
      credentials.server.authority,
      credentials.server.path + path,
      queryParameters,
    );
  }

  Future<http.Response> authenticate(Map<String, String> grantData) async {
    _log.info(
        'authentication attempt (grant_type: ${grantData['grant_type']})');
    final payload = {
      'client_id': credentials.clientId,
      'client_secret': credentials.clientSecret,
      ...grantData,
    };
    final response = await post(
      _buildUri(tokenEnpointPath),
      headers: {'user-agent': await buildUserAgent()},
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
    List<String>? tags,
  }) async {
    var params = {
      if (archive != null) 'archive': archive ? 1 : 0,
      if (starred != null) 'starred': starred ? 1 : 0,
      if (tags != null) 'tags': tags.join(','),
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

  Stream<List<WallabagEntry>> fetchAllEntries({
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
    void Function(float)? onProgress,
  }) async* {
    var pageIndex = page;
    var lastPage = pageIndex + 1; // start with +1 just to start the loop
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
        _log.severe(
            'error fetching entries (page $pageIndex)', source.toString(), st);
        if (source is WallabagError) {
          rethrow;
        } else if (source is Exception) {
          throw WallabagError.fromException(source);
        } else {
          throw WallabagError.fromException(Exception(source.toString()));
        }
      }
      lastPage = pageData.pages;
      _log.info('fetched entries (page $pageIndex of $lastPage)');
      onProgress?.call(pageIndex / lastPage);
      pageIndex++;
      yield pageData.embedded.items;
    }
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

  static Future<WallabagClient> init({Credentials? credentials}) async {
    _instance = await WallabagClient.build(credentials: credentials);
    return _instance!;
  }

  static WallabagClient get() {
    assert(_instance != null);
    return _instance!;
  }

  static bool get isReady => _instance != null && _instance!.canRefreshToken;
}
