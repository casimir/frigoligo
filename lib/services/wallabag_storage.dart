import 'dart:async';

import 'package:drift/drift.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

    return deletedCount;
  }

  Future<void> updateAppBadge() async {
    final settings = ref.read(settingsProvider);
    if (!AppBadge.isSupportedSync || !settings[Sk.appBadge]) return;

    final unread = await DB().articlesDao.countUnread();
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

  Future<void> persistArticle(Article article) =>
      DB().articlesDao.updateOne(article);

  Future<void> deleteArticle(int articleId) async {
    final wallabag = (await ref.read(clientProvider.future))!;

    await wallabag.deleteEntry(articleId);
    final deleted = await DB().articlesDao.deleteOne(articleId);
    if (deleted > 0) _log.info('deleted $deleted entries from the database');
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
