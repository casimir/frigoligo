import 'package:drift/drift.dart';

import 'database/database.dart';
import 'database/models/article.drift.dart';

class LocalStorageService {
  LocalStorageService({required DB db})
    : dbVersion = db.schemaVersion,
      articles = ArticlesManager(db),
      database = DatabaseManager(db),
      metadata = MetadataManager(db),
      remoteActions = RemoteActionsManager(db),
      tags = TagsManager(db);

  final int dbVersion;
  final ArticlesManager articles;
  final DatabaseManager database;
  final MetadataManager metadata;
  final RemoteActionsManager remoteActions;
  final TagsManager tags;

  @Deprecated('this getter will be deleted at some point')
  DB get db => database._db;
}

// A simple wrapper to avoid leaking drift outside of the service.
class StorageQuery<T> {
  StorageQuery(this._query);

  final Selectable<T> _query;

  Future<List<T>> get() => _query.get();

  Future<T?> getSingle() => _query.getSingleOrNull();

  Stream<List<T>> watch() => _query.watch();

  Stream<T> watchSingle() => _query.watchSingle();

  Stream<T?> watchSingleOrNull() => _query.watchSingleOrNull();
}

enum TextMode { all, title, content }

class ArticlesManager {
  const ArticlesManager(this._db);

  final DB _db;

  /// Get the data of an article (everything but the content).
  ///
  /// Returns an [Article] instance with the content set to an empty string if
  /// the field is not null.
  StorageQuery<Article> getData(int id) {
    final t = _db.articles;
    final columns = t.$columns.where((c) => c.name != 'content').toList();
    final contentIsNotNull = t.content.isNotNull();

    final query =
        (t.selectOnly()
              ..addColumns([...columns, contentIsNotNull])
              ..where(t.id.equals(id)))
            .map(
              (row) => Article(
                id: row.read(t.id)!,
                createdAt: row.read(t.createdAt)!,
                updatedAt: row.read(t.updatedAt)!,
                title: row.read(t.title)!,
                domainName: row.read(t.domainName),
                url: row.read(t.url)!,
                content: row.read(contentIsNotNull) != null ? '' : null,
                language: row.read(t.language),
                readingTime: row.read(t.readingTime)!,
                previewPicture: row.read(t.previewPicture),
                archivedAt: row.read(t.archivedAt),
                starredAt: row.read(t.starredAt),
                tags: row.readWithConverter(t.tags)!,
              ),
            );

    return StorageQuery(query);
  }

  /// Get the content of the article.
  StorageQuery<String?> getContent(int id) {
    final t = _db.articles;
    final query =
        (t.selectOnly()
              ..addColumns([t.content])
              ..where(t.id.equals(id)))
            .map((row) => row.read(t.content));
    return StorageQuery(query);
  }

  /// Create or update the article. If the article already exists in storage but
  /// has different reading time, the associated scroll position is deleted.
  ///
  /// Returns the number of affected rows.
  Future<int> update(Article article) async {
    return _db.transaction(() async {
      var count = await _db.articles.insertOnConflictUpdate(
        article.toCompanion(false),
      );

      final position = await _db.managers.articleScrollPositions
          .filter((f) => f.id.equals(article.id))
          .getSingleOrNull();
      if (position != null && position.readingTime != article.readingTime) {
        count += await _db.articleScrollPositions.deleteWhere(
          (f) => f.id.equals(article.id),
        );
      }

      return count;
    });
  }

  /// Delete the article and the associated scroll position.
  ///
  /// Returns the number of affected rows.
  Future<int> delete(int articleId) async {
    return _db.transaction(() async {
      var count = 0;
      count += await _db.articles.deleteWhere((f) => f.id.equals(articleId));
      count += await _db.articleScrollPositions.deleteWhere(
        (f) => f.id.equals(articleId),
      );
      return count;
    });
  }

  String _buildTextQuery(String text, [TextMode textMode = TextMode.all]) {
    final columnFilter = switch (textMode) {
      TextMode.all => '',
      TextMode.title => 'title : ',
      TextMode.content => 'content : ',
    };
    final quotedText = '"$text"';
    final cleanedText = quotedText.trim().split(RegExp(r'\s+')).join(' AND ');
    final suffix = cleanedText.endsWith('*') ? '' : '*'; // ensure some matches
    return columnFilter + cleanedText + suffix;
  }

  Expression<bool> _buildWhereStatement({
    required bool? archived,
    required bool onlyStarred,
    required List<String> domains,
    required List<String> tags,
  }) {
    final t = _db.articles;
    final predicates = <Expression<bool>>[];

    if (archived != null) {
      predicates.add(
        archived ? t.archivedAt.isNotNull() : t.archivedAt.isNull(),
      );
    }

    if (onlyStarred) {
      predicates.add(t.starredAt.isNotNull());
    }

    if (domains.isNotEmpty) {
      predicates.add(
        Expression.or(domains.map((domain) => t.domainName.contains(domain))),
      );
    }

    if (tags.isNotEmpty) {
      predicates.add(Expression.or(tags.map((tag) => t.tags.contains(tag))));
    }

    return Expression.and(predicates);
  }

  StorageQuery<int> count({
    required String text,
    required TextMode textMode,
    required bool? archived,
    required bool onlyStarred,
    required List<String> tags,
    required List<String> domains,
  }) {
    Expression<bool> predicate([_, _]) => _buildWhereStatement(
      archived: archived,
      onlyStarred: onlyStarred,
      tags: tags,
      domains: domains,
    );
    return text.isNotEmpty
        ? StorageQuery(
            _db.articleDrift.articleCountForText(
              _buildTextQuery(text),
              predicate: predicate,
            ),
          )
        : StorageQuery(_db.articles.count(where: predicate));
  }

  StorageQuery<int> listIds({
    required String text,
    required TextMode textMode,
    required bool? archived,
    required bool onlyStarred,
    required List<String> tags,
    required List<String> domains,
  }) {
    final t = _db.articles;
    final whereStatement = _buildWhereStatement(
      archived: archived,
      onlyStarred: onlyStarred,
      tags: tags,
      domains: domains,
    );
    final statement = text.isNotEmpty
        ? _db.articleDrift.articleIdsForText(
            _buildTextQuery(text),
            predicate: (_, _) => whereStatement,
          )
        : (t.selectOnly()
                ..addColumns([t.id])
                ..where(whereStatement)
                ..orderBy([OrderingTerm.desc(t.createdAt)]))
              .map((row) => row.read(t.id)!);
    return StorageQuery(statement);
  }

  Future<List<String>> listDomains({
    required String text,
    required TextMode textMode,
    required bool? archived,
    required bool onlyStarred,
    required List<String> tags,
  }) {
    final t = _db.articles;
    final whereStatement = _buildWhereStatement(
      archived: archived,
      onlyStarred: onlyStarred,
      domains: [],
      tags: tags,
    );
    return (t.selectOnly(distinct: true)
          ..addColumns([t.domainName])
          ..where(whereStatement))
        .map((row) => row.read(t.domainName)!)
        .get();
  }

  Future<List<String>> listTags({
    required String text,
    required TextMode textMode,
    required bool? archived,
    required bool onlyStarred,
    required List<String> domains,
  }) async {
    final t = _db.articles;
    final whereStatement = _buildWhereStatement(
      archived: archived,
      onlyStarred: onlyStarred,
      domains: domains,
      tags: [],
    );
    final tagLists =
        await (t.selectOnly(distinct: true)
              ..addColumns([t.tags])
              ..where(whereStatement))
            .map((row) => row.readWithConverter(t.tags)!)
            .get();
    final tags = tagLists.expand((it) => it).toSet().toList();
    tags.sort();
    return tags;
  }

  StorageQuery<double?> getReadingProgress(int id) {
    final t = _db.articleScrollPositions;
    final query =
        (t.selectOnly()
              ..addColumns([t.progress])
              ..where(t.id.equals(id)))
            .map((row) => row.read(t.progress));
    return StorageQuery(query);
  }

  Future<void> setReadingProgress(int id, double progress) async {
    await _db.transaction(() async {
      final readingTime =
          await (_db.articles.selectOnly()
                ..addColumns([_db.articles.readingTime])
                ..where(_db.articles.id.equals(id)))
              .map((row) => row.read(_db.articles.readingTime)!)
              .getSingle();
      await _db.managers.articleScrollPositions.create(
        (o) => o(id: Value(id), readingTime: readingTime, progress: progress),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<int> countUnread() => _db.articlesDao.countUnread();

  Future<Set<int>> getAllIds() => _db.articlesDao.getAllIds();

  Future<void> updateAll(List<Article> articles) =>
      _db.articlesDao.updateAll(articles);
}

class DatabaseManager {
  const DatabaseManager(this._db);

  final DB _db;

  /// Clears all data, optionally preserving scroll positions.
  Future<void> clear({bool keepPositions = false}) =>
      _db.clear(keepPositions: keepPositions);
}

class MetadataManager {
  const MetadataManager(this._db);

  final DB _db;

  static const _keyLastSyncTS = 'lastRefreshTS';

  Future<int?> getLastSyncTS() async {
    final row = await _db.managers.metadata
        .filter((f) => f.key.equals(_keyLastSyncTS))
        .getSingleOrNull();
    return row != null ? int.parse(row.value) : null;
  }

  Future<void> setLastSyncTS(int timestamp) => _db.managers.metadata.create(
    (o) => o(key: _keyLastSyncTS, value: timestamp.toString()),
    mode: InsertMode.insertOrReplace,
  );
}

class RemoteActionsManager {
  const RemoteActionsManager(this._db);

  final DB _db;

  Future<bool> exists(int key) =>
      _db.managers.remoteActions.filter((f) => f.key.equals(key)).exists();

  Future<void> create({
    required int key,
    required DateTime createdAt,
    required String className,
    required String jsonParams,
  }) => _db.managers.remoteActions.create(
    (o) => o(
      key: key,
      createdAt: createdAt,
      className: className,
      jsonParams: jsonParams,
    ),
  );

  Future<int> delete(int key) =>
      _db.managers.remoteActions.filter((f) => f.key.equals(key)).delete();

  Future<void> clear() => _db.managers.remoteActions.delete();

  Future<int> count() => _db.managers.remoteActions.count(distinct: false);

  Future<List<({String className, String jsonParams})>>
  getAllOrderedByCreation() async {
    final rows =
        await (_db.managers.remoteActions..orderBy((o) => o.createdAt.asc()))
            .get();
    return rows
        .map((row) => (className: row.className, jsonParams: row.jsonParams))
        .toList();
  }
}

class TagsManager {
  const TagsManager(this._db);

  final DB _db;

  /// Returns a list of all tag names.
  Future<List<String>> getAll() async {
    final t = _db.articles;
    final tagLists = await (t.selectOnly()..addColumns([t.tags]))
        .map((row) => row.readWithConverter(t.tags)!)
        .get();
    return tagLists.expand((it) => it).toSet().toList();
  }
}
