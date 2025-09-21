import 'package:logging/logging.dart';

import '../../../data/services/local/storage/database/models/article.drift.dart';
import '../wallabag/endpoints.dart';
import '../wallabag/types.dart';
import 'api_methods.dart';

final _log = Logger('clients.wallabag');

Article _toArticle(WallabagEntry entry) => Article(
      id: entry.id,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      title: entry.title!,
      domainName: entry.domainName,
      url: entry.url!,
      content: entry.content,
      language: entry.language,
      readingTime: entry.readingTime,
      previewPicture: entry.previewPicture,
      archivedAt: entry.archivedAt,
      starredAt: entry.starredAt,
      tags: entry.tags.map((e) => e.label).toList(),
    );

int? _toTimestamp(DateTime? date) =>
    date != null ? date.millisecondsSinceEpoch ~/ 1000 : null;

mixin WallabagMethods on WallabagClientEndpoints implements ApiMethods {
  @override
  Future<Article> createArticle(String url, {List<String>? tags}) async {
    final entry = await createEntry(url, tags: tags);
    return _toArticle(entry);
  }

  @override
  Stream<List<Article>> listArticles({
    DateTime? since,
    ApiProgressCallback? onProgress,
  }) async* {
    final entriesStream = fetchAllEntries(
      since: _toTimestamp(since),
      onProgress: onProgress,
    );
    await for (final entries in entriesStream) {
      yield entries.map(_toArticle).toList();
    }
  }

  @override
  Future<Article> getArticle(int id) async {
    final entry = await getEntry(id);
    return _toArticle(entry);
  }

  @override
  Future<Article> updateArticle(
    int id, {
    bool? archived,
    bool? starred,
    List<String>? tags,
  }) async {
    final entry = await patchEntry(
      id,
      archive: archived,
      starred: starred,
      tags: tags,
    );
    return _toArticle(entry);
  }

  @override
  Future<ApiActionResult> deleteArticle(int id) async {
    await deleteEntry(id);
    return ApiActionResult.succeed;
  }

  @override
  Future<ApiActionResult> recrawlArticle(int id) async {
    final reloaded = await reloadEntry(id);
    return reloaded ? ApiActionResult.succeed : ApiActionResult.failed;
  }

  @override
  Future<List<ArticleOperation>> listOperations({
    DateTime? since,
    required Set<int> localIds,
    ApiProgressCallback? onProgress,
  }) async {
    final entriesStream = fetchAllEntries(
      since: _toTimestamp(since),
      perPage: 300,
      detail: DetailValue.metadata,
      onProgress: onProgress,
    );
    final operations = <ArticleOperation>[];
    var creationsCount = 0;

    await for (final entries in entriesStream) {
      operations.addAll(
        entries.map((e) {
          if (since != null && e.createdAt.isAfter(since)) {
            return ArticleOperation(
              articleId: e.id,
              type: ArticleOpType.created,
              performedAt: e.createdAt,
            );
          } else if (false) {
            // will be available in a future version of the API
            // } else if (e.deletedAt != null) {
            // return ArticleOperation(
            //   articleId: e.id,
            //   type: ArticleOpType.deleted,
            //   performedAt: e.deletedAt,
            // );
          } else {
            return ArticleOperation(
              articleId: e.id,
              type: ArticleOpType.updated,
              performedAt: e.updatedAt,
            );
          }
        }),
      );
    }

    // check for deletions since the server doesn't support deletion enumeration
    final remoteCount = await fetchTotalEntriesCount();
    final delta = localIds.length + creationsCount - remoteCount;
    if (delta > 0) {
      _log.info('detected delta ($delta) with the server');
      final entriesStream = fetchAllEntries(
        perPage: 300,
        detail: DetailValue.metadata,
      );
      await for (final entries in entriesStream) {
        localIds.removeAll(entries.map((e) => e.id));
      }

      _log.info('found ${localIds.length} external deletions');
      for (final id in localIds) {
        operations.add(
          ArticleOperation(
            articleId: id,
            type: ArticleOpType.deleted,
            // performedAt: e.deletedAt,
            performedAt: DateTime.now(),
          ),
        );
      }
    }

    operations.sort((a, b) => a.performedAt.compareTo(b.performedAt));
    return operations;
  }
}
