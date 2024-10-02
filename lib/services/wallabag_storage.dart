import 'dart:async';

import 'package:drift/drift.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants.dart';
import '../db/daos/articles.dart';
import '../db/database.dart';
import '../db/extensions/article.dart';
import '../db/models/article.drift.dart';
import '../native/appbadge.dart';
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

  Expression<bool> _buildFilters(Articles t, WQuery wq) {
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

    if (wq.domains != null) {
      filters.add(Expression.or(
          wq.domains!.map((domain) => t.domainName.contains(domain))));
    }

    return Expression.and(filters);
  }

  Selectable<int> _selectFilterIds(WQuery wq) {
    if (wq.text != null) {
      return DB().articlesDao.selectArticleIdsForText(
            wq.text!,
            mode: wq.textMode ?? SearchTextMode.all,
            where: (t) => _buildFilters(t, wq),
          );
    } else {
      final t1 = DB().articles;
      return (t1.selectOnly()
            ..addColumns([t1.id])
            ..where(_buildFilters(t1, wq))
            ..orderBy([OrderingTerm.desc(t1.createdAt)]))
          .map((row) => row.read(t1.id)!);
    }
  }

  Future<Article?> index(int n, WQuery wq) async {
    if (n < 0 || n >= await count(wq)) return null;

    final ids = await _selectFilterIds(wq).get();
    final db = DB();
    return db.managers.articles
        .filter((f) => f.id.equals(ids[n]))
        .getSingleOrNull(distinct: false);
  }

  Future<int?> indexOf(int articleId, WQuery wq) async {
    if (articleId <= 0) return null;

    final ids = await _selectFilterIds(wq).get();
    final index = ids.indexOf(articleId);
    return index >= 0 ? index : null;
  }

  Future<int> count(WQuery wq) =>
      // a count query should be faster but fetching and counting PKs should be
      // fast enough and avoid duplicating code
      _selectFilterIds(wq).get().then((ids) => ids.length);

  Future<List<String>> getTags() async {
    final t1 = DB().articles;
    final tagLists = await (t1.selectOnly()..addColumns([t1.tags]))
        .map((row) => row.readWithConverter(t1.tags)!)
        .get();
    final tags = tagLists.expand((it) => it).toSet().toList();
    tags.sort();
    return tags;
  }

  Future<int> _syncRemoteDeletes() async {
    _log.info('checking for server-side deletions');
    final wallabag = (await ref.read(clientProvider.future))!;

    final remoteCount = await wallabag.fetchTotalEntriesCount();

    final t1 = DB().articles;
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

    final deletedCount = await DB().transaction(() async {
      var count = 0;
      count += await DB()
          .managers
          .articles
          .filter((f) => f.id.isIn(localIds))
          .delete();
      count += await DB()
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
    if (!AppBadge.isSupportedSync || !settings[Sk.appBadge]) return;

    final unread = await count(
        WQuery(state: StateFilter.unread, starred: StarredFilter.all));
    if (unread == 0) {
      return AppBadge.remove();
    } else {
      _log.info('updating app badge to $unread');
      return AppBadge.update(unread);
    }
  }

  Future<void> removeAppBadge() async {
    if (!AppBadge.isSupportedSync) return;
    return AppBadge.remove();
  }

  Future<void> clearArticles({bool keepPositions = true}) async {
    DB().clear(keepPositions: keepPositions);
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
      await DB().articlesDao.updateAll(entries.map((e) => e.toArticle()));
      _log.info('saved ${entries.length} entries to the database');
      if (entries.isNotEmpty) ref.invalidateSelf();

      count += entries.length;
    }
    _log.info(
        'completed refresh of $count entries in ${stopwatch.elapsed.inSeconds} s');

    final now = DateTime.now().millisecondsSinceEpoch / 1000;
    await DB().metadataDao.setLastSyncTS(now.toInt());

    _syncRemoteDeletes();

    updateAppBadge();

    return count;
  }

  Future<int> incrementalRefresh(
      {int? threshold, void Function(double)? onProgress}) async {
    final int? since = await DB().metadataDao.getLastSyncTS();
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
    final writeCount = await DB().articlesDao.updateOne(article);
    if (writeCount > 0) ref.invalidateSelf();
  }

  Future<void> deleteArticle(int articleId) async {
    final wallabag = (await ref.read(clientProvider.future))!;

    await wallabag.deleteEntry(articleId);
    final deleted = await DB().articlesDao.deleteOne(articleId);
    if (deleted > 0) ref.invalidateSelf();
  }

  Future<void> editArticle(
    int articleId, {
    bool? archive,
    bool? starred,
    List<String>? tags,
  }) async {
    final wallabag = (await ref.read(clientProvider.future))!;
    final entry = await wallabag.patchEntry(
      articleId,
      archive: archive,
      starred: starred,
      tags: tags,
    );
    await persistArticle(entry.toArticle());
  }
}

// FIXME use sentinel values to avoid needing clear*() methods
class WQuery {
  WQuery({
    this.text,
    this.textMode,
    this.state,
    this.starred,
    this.tags,
    this.domains,
  });

  String? text;
  SearchTextMode? textMode;
  StateFilter? state;
  StarredFilter? starred;
  List<String>? tags;
  List<String>? domains;

  WQuery dup() => WQuery(
        text: text,
        textMode: textMode,
        state: state,
        starred: starred,
        tags: tags,
        domains: domains,
      );

  WQuery override(WQuery wq) => WQuery(
        text: wq.text ?? text,
        textMode: wq.textMode ?? textMode,
        state: wq.state ?? state,
        starred: wq.starred ?? starred,
        tags: wq.tags ?? tags,
        domains: wq.domains ?? domains,
      );
}
