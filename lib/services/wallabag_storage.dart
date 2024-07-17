import 'dart:async';

import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants.dart';
import '../models/article.dart';
import '../models/article_scroll_position.dart';
import '../models/db.dart';
import '../models/remote_action.dart';
import '../providers/settings.dart';
import '../server/providers/wallabag_client.dart';
import '../wallabag/client.dart';

part 'wallabag_storage.g.dart';

final _log = Logger('wallabag.storage');

class WStorageToken {}

@riverpod
class WStorage extends _$WStorage {
  StreamSubscription? _watcher;

  @override
  WStorageToken build() {
    _watcher?.cancel();
    _watcher =
        DB.get().articles.watchLazy().listen((_) => ref.invalidateSelf());
    ref.onDispose(() => _watcher?.cancel());
    return WStorageToken();
  }

  Query<R> _buildQuery<R>(WQuery wq, {String? sort, String? property}) {
    List<FilterOperation> conditions = [];
    if (wq.state != null && wq.state != StateFilter.all) {
      conditions.add(wq.state == StateFilter.archived
          ? const FilterCondition.isNotNull(property: 'archivedAt')
          : const FilterCondition.isNull(property: 'archivedAt'));
    }
    if (wq.starred == StarredFilter.starred) {
      conditions.add(const FilterCondition.isNotNull(property: 'starredAt'));
    }

    if (wq.tags != null) {
      if (wq.tags!.length == 1) {
        conditions.add(
            FilterCondition.contains(property: 'tags', value: wq.tags![0]));
      } else {
        List<FilterCondition> tagFilters = wq.tags!
            .map(
                (tag) => FilterCondition.contains(property: 'tags', value: tag))
            .toList();
        conditions.add(FilterGroup.or(tagFilters));
      }
    }

    FilterOperation? filter;
    if (conditions.length == 1) {
      filter = conditions[0];
    } else {
      filter = FilterGroup.and(conditions);
    }

    List<SortProperty> sortBy = [];
    if (sort != null) {
      final String property;
      final Sort direction;
      if (sort.startsWith('-')) {
        property = sort.substring(1);
        direction = Sort.desc;
      } else {
        property = sort;
        direction = Sort.asc;
      }
      sortBy.add(SortProperty(property: property, sort: direction));
    }

    return DB.get().articles.buildQuery(
          filter: filter,
          sortBy: sortBy,
          property: property,
        );
  }

  List<Article> all(WQuery wq) =>
      _buildQuery<Article>(wq, sort: '-createdAt').findAllSync();

  Article? index(int n, WQuery wq) {
    if (n < 0 || n >= count(wq)) return null;
    final ids =
        _buildQuery(wq, sort: '-createdAt', property: 'id').findAllSync();
    return DB.get().articles.getSync(ids[n])!;
  }

  int? indexOf(int articleId, WQuery wq) {
    if (articleId <= 0) return null;
    final ids =
        _buildQuery(wq, sort: '-createdAt', property: 'id').findAllSync();
    final index = ids.indexOf(articleId);
    return index >= 0 ? index : null;
  }

  int count(WQuery wq) => _buildQuery(wq).countSync();

  List<String> getTags() {
    var tags = DB
        .get()
        .articles
        .where()
        .tagsProperty()
        .findAllSync()
        .expand((it) => it)
        .toSet()
        .toList();
    tags.sort();
    return tags;
  }

  Future<int> _syncRemoteDeletes() async {
    _log.info('checking for server-side deletions');
    final wallabag = (await ref.read(clientProvider.future))!;
    final db = DB.get();

    final remoteCount = await wallabag.fetchTotalEntriesCount();
    var localIds = (await db.articles.where().idProperty().findAll()).toSet();
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

    final deletedCount = await db.writeTxn(() async {
      final res = await db.articles.deleteAll(localIds.toList());
      await db.articleScrollPositions.deleteAll(localIds.toList());
      return res;
    });
    _log.info('removed $deletedCount entries from database');

    return deletedCount;
  }

  Future<void> updateAppBadge() async {
    final settings = ref.read(settingsProvider);
    if (!appBadgeSupported || !settings[Sk.appBadge]) return;

    final unread =
        count(WQuery(state: StateFilter.unread, starred: StarredFilter.all));
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
    final db = DB.get();

    await db.writeTxn(() async {
      await db.articles.clear();
      if (!keepPositions) await db.articleScrollPositions.clear();
      await db.remoteActions.clear();
    });
    _log.info('cleared the whole articles collection');
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

    if (since == null) clearArticles();

    final stopwatch = Stopwatch()..start();
    var entriesStream =
        wallabag.fetchAllEntries(since: since, onProgress: onProgress);
    await for (final entries in entriesStream) {
      final articles = {
        for (var e in entries) e.id: Article.fromWallabagEntry(e)
      };
      final positions =
          await db.articleScrollPositions.getAll(articles.keys.toList());
      final invalidPositions = positions
          .whereType<ArticleScrollPosition>()
          .where((e) => e.readingTime != articles[e.id]?.readingTime)
          .map((e) => e.id!)
          .toList();

      final putCount = await db.writeTxn(() async {
        final res = await db.articles.putAll(articles.values.toList());
        await db.articleScrollPositions.deleteAll(invalidPositions);
        return res.length;
      });
      _log.info('saved $putCount entries to the database');

      count += entries.length;
    }
    _log.info(
        'completed refresh of $count entries in ${stopwatch.elapsed.inSeconds} s');

    final now = DateTime.now().millisecondsSinceEpoch / 1000;
    ref.read(settingsProvider.notifier).set(Sk.lastRefresh, now.toInt());

    _syncRemoteDeletes();

    updateAppBadge();

    return count;
  }

  Future<int> incrementalRefresh(
      {int? threshold, void Function(double)? onProgress}) async {
    final int since = ref.read(settingsProvider)[Sk.lastRefresh];
    if (threshold != null && since > 0) {
      final now = DateTime.now().millisecondsSinceEpoch / 1000;
      final elapsed = now - since;
      if (elapsed < threshold) {
        _log.info(
            'incremental refresh throttled (last: ${elapsed.toStringAsFixed(0)} s)');
        return 0;
      }
    }
    return fullRefresh(since: since > 0 ? since : null, onProgress: onProgress);
  }

  Future<void> persistArticle(Article article) async {
    final db = DB.get();

    final scrollPosition = await db.articleScrollPositions.get(article.id!);
    await db.writeTxn(() async {
      await db.articles.put(article);
      if (scrollPosition?.readingTime != article.readingTime) {
        await db.articleScrollPositions.delete(article.id!);
      }
    });
  }

  Future<void> deleteArticle(int articleId) async {
    final db = DB.get();
    final wallabag = (await ref.read(clientProvider.future))!;

    await wallabag.deleteEntry(articleId);
    await db.writeTxn(() async {
      await db.articles.delete(articleId);
      await db.articleScrollPositions.delete(articleId);
    });
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
    final article = Article.fromWallabagEntry(entry);
    await persistArticle(article);
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
