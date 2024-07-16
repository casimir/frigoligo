import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:universal_platform/universal_platform.dart';

import '../app_info.dart';
import 'models/entry.dart';
import 'models/info.dart';

part 'client.g.dart';

final _log = Logger('wallabag.client');

void throwOnError(http.Response response, {List<int> expected = const [200]}) {
  if (!expected.contains(response.statusCode)) {
    throw ServerError.fromResponse(response);
  }
}

class ServerError implements Exception {
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
      message = json['error_description'] ?? json['error'];
    } catch (_) {}
    return ServerError(message, response: response);
  }
  factory ServerError.fromException(Exception e, {http.Response? response}) =>
      ServerError('unknown error', source: e, response: response);

  bool get isInvalidTokenError {
    if (manuallyInvalidated) return true;

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
      ServerError e => e,
      Exception e => ServerError.fromException(e, response: response),
      _ => ServerError.fromException(Exception(source.toString()),
          response: response),
    };
  }
}

abstract class WallabagClient extends http.BaseClient {
  Logger get logger => _log;
  String? get userAgent => UniversalPlatform.isWeb ? null : AppInfo.userAgent;

  Future<Uri> buildUri(String path, [Map<String, dynamic>? queryParameters]);
}

extension WallabagClientEndpoints on WallabagClient {
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
    final response = await get(await buildUri(
      '/api/entries',
      params.map((key, value) => MapEntry(key, value.toString())),
    ));
    throwOnError(response);
    return safeDecode(response, WallabagPaginatedEntries.fromJson);
  }

  Future<WallabagEntry> getEntry(int id) async {
    final response = await get(await buildUri('/api/entries/$id'));
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
      await buildUri('/api/entries'),
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
      await buildUri('/api/entries/$id'),
      body: params.map((key, value) => MapEntry(key, value.toString())),
    );
    throwOnError(response);
    return response;
  }

  Future<http.Response> deleteEntry(int id) async {
    final response = await delete(await buildUri('/api/entries/$id'));
    // avoid blocking the syncer with a 404 status (nothing to delete)
    throwOnError(response, expected: [200, 404]);
    return response;
  }

  Future<WallabagInfo> getInfo() async {
    final response = await get(await buildUri('/api/info'));
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
    void Function(double)? onProgress,
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
        logger.severe(
            'error fetching entries (page $pageIndex)', source.toString(), st);
        if (source is ServerError) {
          rethrow;
        } else if (source is Exception) {
          throw ServerError.fromException(source);
        } else {
          throw ServerError.fromException(Exception(source.toString()));
        }
      }
      lastPage = pageData.pages;
      logger.info('fetched entries (page $pageIndex of $lastPage)');
      onProgress?.call(pageIndex / lastPage);
      pageIndex++;
      yield pageData.embedded.items;
    }
  }
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
