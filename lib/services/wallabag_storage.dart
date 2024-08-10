import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants.dart';
import '../db/database.dart';
import '../db/extensions/article.dart';
import '../providers/settings.dart';
import '../server/providers/client.dart';
import '../wallabag/client.dart';

part 'wallabag_storage.g.dart';

final _log = Logger('wallabag.storage');

class WStorageToken {}

@riverpod
class WStorage extends _$WStorage {
  @override
  WStorageToken build() => WStorageToken();

  Expression<bool> _buildFilters($ArticlesTable t, WQuery wq) {
    final filters = <Expression<bool>>[];

    if (wq.state != null && wq.state != StateFilter.all) {
      filters.add(wq.state == StateFilter.archived
          ? t.archivedAt.isNotNull()
          : t.archivedAt.isNull());
    }

    if (wq.starred == StarredFilter.starred) {
      filters.add(t.starredAt.isNotNull());
    }

    if (wq.tags != null) {
      filters.add(Expression.or(wq.tags!.map((tag) => t.tags.contains(tag))));
    }

    return Expression.and(filters);
  }

  Future<Article?> index(int n, WQuery wq) async {
    if (n < 0 || n >= await count(wq)) return null;

    final db = DB.get();
    final t1 = db.articles;
    final ids = await (t1.selectOnly()
          ..addColumns([t1.id])
          ..where(_buildFilters(t1, wq))
          ..orderBy([OrderingTerm.desc(t1.createdAt)]))
        .map((row) => row.read(t1.id)!)
        .get();
    return db.managers.articles
        .filter((f) => f.id.equals(ids[n]))
        .getSingleOrNull();
  }

  Future<int?> indexOf(int articleId, WQuery wq) async {
    if (articleId <= 0) return null;
    final t1 = DB.get().articles;
    final ids = await (DB.get().articles.selectOnly()
          ..addColumns([t1.id])
          ..where(_buildFilters(t1, wq))
          ..orderBy([OrderingTerm.desc(t1.createdAt)]))
        .map((row) => row.read(t1.id)!)
        .get();
    final index = ids.indexOf(articleId);
    return index >= 0 ? index : null;
  }

  Future<int> count(WQuery wq) =>
      DB.get().articles.count(where: (t) => _buildFilters(t, wq)).getSingle();

  Future<List<String>> getTags() async {
    final t1 = DB.get().articles;
    final tagLists = await (t1.selectOnly()..addColumns([t1.tags])).get()
        as List<List<String>>;
    final tags = tagLists.expand((it) => it).toSet().toList();
    tags.sort();
    return tags;
  }

  Future<int> _syncRemoteDeletes() async {
    _log.info('checking for server-side deletions');
    final wallabag = (await ref.read(clientProvider.future))!;

    final remoteCount = await wallabag.fetchTotalEntriesCount();

    final t1 = DB.get().articles;
    var localIds = (await (t1.selectOnly()..addColumns([t1.id]))
            .map((row) => row.read(t1.id)!)
            .get())
        .toSet();

    final delta = localIds.length - remoteCount;
    if (delta <= 0) return 0;
    _log.info('server-side deletion detected: delta=$delta');

    // seems overkill but the only way to enumerate all entry ids efficiently
    final entriesStream = wallabag.fetchAllEntries(
      perPage: 100,
      detail: DetailValue.metadata,
    );
    await for (final entries in entriesStream) {
      localIds = localIds.difference(entries.map((e) => e.id).toSet());
    }

    final deletedCount = await DB.get().transaction(() async {
      var count = 0;
      count += await DB
          .get()
          .managers
          .articles
          .filter((f) => f.id.isIn(localIds))
          .delete();
      count += await DB
          .get()
          .managers
          .articleScrollPositions
          .filter((f) => f.id.isIn(localIds))
          .delete();
      return count;
    });
    _log.info('removed $deletedCount entries from database');
    if (deletedCount > 0) ref.invalidateSelf();

    return deletedCount;
  }

  Future<void> updateAppBadge() async {
    final settings = ref.read(settingsProvider);
    if (!appBadgeSupported || !settings[Sk.appBadge]) return;

    final unread = await count(
        WQuery(state: StateFilter.unread, starred: StarredFilter.all));
    if (unread == 0) {
      return FlutterAppBadger.removeBadge();
    } else {
      _log.info('updating app badge to $unread');
      return FlutterAppBadger.updateBadgeCount(unread);
    }
  }

  Future<void> removeAppBadge() async {
    if (!appBadgeSupported) return;
    return FlutterAppBadger.removeBadge();
  }

  Future<void> clearArticles({bool keepPositions = true}) async {
    DB.get().clear(keepPositions: keepPositions);
    _log.info('cleared the local cache (articles and pending actions)');
    ref.invalidateSelf();
    updateAppBadge();
  }

  Future<int> fullRefresh(
      {int? since, void Function(double)? onProgress}) async {
    final wallabag = await ref.read(clientProvider.future);
    if (wallabag == null) {
      // at this point the session can't be null, it must have been invalidated
      throw const ServerError('invalid session', manuallyInvalidated: true);
    }

    final db = DB.get();

    var count = 0;
    final sinceRepr = since != null
        ? DateTime.fromMillisecondsSinceEpoch(since * 1000).toIso8601String()
        : null;
    _log.info('starting refresh with since=$sinceRepr');

    if (since == null) await clearArticles();

    final stopwatch = Stopwatch()..start();
    var entriesStream =
        wallabag.fetchAllEntries(since: since, onProgress: onProgress);
    await for (final entries in entriesStream) {
      final articles = {for (var e in entries) e.id: e.toArticle()};
      final positions = await db.managers.articleScrollPositions
          .filter((f) => f.id.isIn(articles.keys))
          .get();
      final invalidPositions = positions
          .where((e) => e.readingTime != articles[e.id]?.readingTime)
          .map((e) => e.id)
          .toList();

      await db.transaction(() async {
        await db.batch((batch) {
          batch.insertAll(db.articles, articles.values);
        });
        await db.managers.articleScrollPositions
            .filter((f) => f.id.isIn(invalidPositions))
            .delete();
      });
      _log.info('saved ${articles.length} entries to the database');
      if (articles.isNotEmpty) ref.invalidateSelf();

      count += entries.length;
    }
    _log.info(
        'completed refresh of $count entries in ${stopwatch.elapsed.inSeconds} s');

    final now = DateTime.now().millisecondsSinceEpoch / 1000;
    await DB.get().metadataDao.setLastSyncTS(now.toInt());

    _syncRemoteDeletes();

    updateAppBadge();

    return count;
  }

  Future<int> incrementalRefresh(
      {int? threshold, void Function(double)? onProgress}) async {
    final int? since = await DB.get().metadataDao.getLastSyncTS();
    if (threshold != null && since != null) {
      final now = DateTime.now().millisecondsSinceEpoch / 1000;
      final elapsed = now - since;
      if (elapsed < threshold) {
        _log.info(
            'incremental refresh throttled (last: ${elapsed.toStringAsFixed(0)} s)');
        return 0;
      }
    }
    return fullRefresh(since: since, onProgress: onProgress);
  }

  Future<void> persistArticle(Article article) async {
    final db = DB.get();

    final scrollPosition = await db.managers.articleScrollPositions
        .filter((f) => f.id.equals(article.id))
        .getSingleOrNull();
    final writeCount = await db.transaction(() async {
      var count = 0;
      count += await db.articles.insertOnConflictUpdate(article);
      if (scrollPosition?.readingTime != article.readingTime) {
        count += await db.managers.articleScrollPositions
            .filter((f) => f.id.equals(article.id))
            .delete();
      }
      return count;
    });
    if (writeCount > 0) ref.invalidateSelf();
  }

  Future<void> deleteArticle(int articleId) async {
    final db = DB.get();
    final wallabag = (await ref.read(clientProvider.future))!;

    await wallabag.deleteEntry(articleId);
    final deleted = await db.transaction(() async {
      var deleted = 0;
      deleted += await db.managers.articles
          .filter((f) => f.id.equals(articleId))
          .delete();
      deleted += await db.managers.articleScrollPositions
          .filter((f) => f.id.equals(articleId))
          .delete();
      return deleted;
    });
    if (deleted > 0) ref.invalidateSelf();
  }

  Future<void> editArticle(
    int articleId, {
    bool? archive,
    bool? starred,
    List<String>? tags,
  }) async {
    final wallabag = (await ref.read(clientProvider.future))!;
    await wallabag.patchEntry(
      articleId,
      archive: archive,
      starred: starred,
      tags: tags,
    );
    final entry = await wallabag.getEntry(articleId);
    await persistArticle(entry.toArticle());
  }
}

class WQuery {
  WQuery({this.state, this.starred, this.tags});

  StateFilter? state;
  StarredFilter? starred;
  List<String>? tags;

  WQuery dup() => WQuery(
        state: state,
        starred: starred,
        tags: tags,
      );

  WQuery override(WQuery wq) => WQuery(
        state: wq.state ?? state,
        starred: wq.starred ?? starred,
        tags: wq.tags ?? tags,
      );
}
