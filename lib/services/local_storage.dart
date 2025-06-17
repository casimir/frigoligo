import 'dart:async';

import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../db/database.dart';
import '../db/models/article.drift.dart';
import '../native/appbadge.dart';
import '../providers/settings.dart';
import '../server/clients.dart';
import '../server/providers/client.dart';

part 'local_storage.g.dart';

final _log = Logger('storage');

class LocalStorageToken {}

@riverpod
class LocalStorage extends _$LocalStorage {
  @override
  LocalStorageToken build() => LocalStorageToken();

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

  Future<int> fullRefresh({
    int? since,
    void Function(double)? onProgress,
  }) async {
    final api = await ref.read(clientProvider.future);
    if (api == null) {
      // at this point the session can't be null, it must have been invalidated
      throw const ServerError('invalid session', manuallyInvalidated: true);
    }

    final stopwatch = Stopwatch()..start();

    var count = 0;
    final sinceDT =
        since != null
            ? DateTime.fromMillisecondsSinceEpoch(since * 1000)
            : null;
    _log.info('starting refresh with since=${sinceDT?.toIso8601String()}');

    if (since == null) {
      await clearArticles();

      final articlesStream = api.listArticles(
        since: sinceDT,
        onProgress: onProgress,
      );
      await for (final articles in articlesStream) {
        await DB().articlesDao.updateAll(articles);
        _log.info('saved ${articles.length} articles to the database');

        count += articles.length;
      }
    } else {
      final operations = await api.listOperations(
        since: sinceDT,
        localIds: await DB().articlesDao.getAllIds(),
        onProgress: onProgress,
      );
      for (final op in operations) {
        switch (op.type) {
          case ArticleOpType.created:
          case ArticleOpType.updated:
            final article = await api.getArticle(op.articleId);
            count += await DB().articlesDao.updateOne(article);
          case ArticleOpType.deleted:
            count += await DB().articlesDao.deleteOne(op.articleId);
        }
      }
    }

    final now = DateTime.now().millisecondsSinceEpoch / 1000;
    await DB().metadataDao.setLastSyncTS(now.toInt());

    updateAppBadge();

    _log.info(
      'completed refresh of $count entries in ${stopwatch.elapsed.inSeconds} s',
    );
    return count;
  }

  Future<int> incrementalRefresh({
    int? threshold,
    void Function(double)? onProgress,
  }) async {
    final int? since = await DB().metadataDao.getLastSyncTS();
    if (threshold != null && since != null) {
      final now = DateTime.now().millisecondsSinceEpoch / 1000;
      final elapsed = now - since;
      if (elapsed < threshold) {
        _log.info(
          'incremental refresh throttled (last: ${elapsed.toStringAsFixed(0)} s)',
        );
        return 0;
      }
    }
    return fullRefresh(since: since, onProgress: onProgress);
  }

  Future<void> persistArticle(Article article) =>
      DB().articlesDao.updateOne(article);

  Future<int> saveArticle(String url, {List<String>? tags}) async {
    final api = (await ref.read(clientProvider.future))!;
    final article = await api.createArticle(url, tags: tags);
    await persistArticle(article);
    return article.id;
  }

  Future<void> deleteArticle(int articleId) async {
    final api = (await ref.read(clientProvider.future))!;

    final result = await api.deleteArticle(articleId);
    if (result == ApiActionResult.succeed) {
      final deleted = await DB().articlesDao.deleteOne(articleId);
      if (deleted > 0) {
        _log.info('deleted article $articleId from the database');
      }
    }
  }

  Future<void> editArticle(
    int articleId, {
    bool? archived,
    bool? starred,
    List<String>? tags,
  }) async {
    final api = (await ref.read(clientProvider.future))!;

    final article = await api.updateArticle(
      articleId,
      archived: archived,
      starred: starred,
      tags: tags,
    );
    await persistArticle(article);
  }

  Future<bool> refetchArticle(int articleId) async {
    final api = (await ref.read(clientProvider.future))!;

    final result = await api.recrawlArticle(articleId);
    final reloaded = result == ApiActionResult.succeed;
    if (reloaded) {
      final article = await api.getArticle(articleId);
      await persistArticle(article);
    }
    return reloaded;
  }
}
