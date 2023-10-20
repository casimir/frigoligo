import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';

import '../constants.dart';
import '../models/article.dart';
import '../models/article_scroll_position.dart';
import '../models/db.dart';
import '../providers/settings.dart';
import '../wallabag/wallabag.dart';

final _log = Logger('wallabag.storage');

class WallabagStorage with ChangeNotifier {
  WallabagStorage(this.settings, {this.onError}) {
    _watcher = db.articles.watchLazy().listen((_) => notifyListeners());

    // ensure a relative freshness of the articles
    _log.info('provider initialization > incremental refresh');
    incrementalRefresh(threshold: autoSyncThrottleSeconds);
  }

  final DBInstance db = DB.get();
  final WallabagClient wallabag = WallabagInstance.get();
  StreamSubscription? _watcher;
  final SettingsProvider settings;
  void Function(Exception)? onError;

  @override
  void dispose() {
    _watcher?.cancel();
    super.dispose();
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

    return db.articles.buildQuery(
      filter: filter,
      sortBy: sortBy,
      property: property,
    );
  }

  List<Article> all(WQuery wq) =>
      _buildQuery<Article>(wq, sort: '-createdAt').findAllSync();

  Article? index(int n, WQuery wq) {
    if (n < 0 || n >= count(wq)) return null;
    var ids = _buildQuery(wq, sort: '-createdAt', property: 'id').findAllSync();
    return db.articles.getSync(ids[n])!;
  }

  int count(WQuery wq) => _buildQuery(wq).countSync();

  List<String> get tags {
    var tags = db.articles
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
    await for (final (entries, err) in entriesStream) {
      if (err != null) {
        onError?.call(err);
        break;
      }
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
    if (!appBadgeSupported) return;

    final unread =
        count(WQuery(state: StateFilter.unread, starred: StarredFilter.all));
    if (unread == 0 || !settings[Sk.appBadge]) {
      FlutterAppBadger.removeBadge();
    } else {
      _log.info('updating app badge to $unread');
      FlutterAppBadger.updateBadgeCount(unread);
    }
  }

  Future<void> clearArticles({bool keepPositions = true}) async {
    await db.writeTxn(() async {
      await db.articles.clear();
      if (!keepPositions) await db.articleScrollPositions.clear();
    });
    _log.info('cleared the whole articles collection');
    updateAppBadge();
  }

  Future<int> fullRefresh(
      {int? since, void Function(double)? onProgress}) async {
    var count = 0;
    final sinceRepr = since != null
        ? DateTime.fromMillisecondsSinceEpoch(since * 1000).toIso8601String()
        : null;
    _log.info('starting refresh with since=$sinceRepr');

    if (since == null) clearArticles();

    try {
      final stopwatch = Stopwatch()..start();
      var entriesStream =
          wallabag.fetchAllEntries(since: since, onProgress: onProgress);
      await for (final (entries, err) in entriesStream) {
        if (err != null) throw err;
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
      settings[Sk.lastRefresh] = now.toInt();

      _syncRemoteDeletes();
    } on Exception catch (e) {
      onError?.call(e);
    }

    updateAppBadge();

    return count;
  }

  Future<int> incrementalRefresh(
      {int? threshold, void Function(double)? onProgress}) async {
    final int since = settings[Sk.lastRefresh];
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
    final scrollPosition = await db.articleScrollPositions.get(article.id!);
    await db.writeTxn(() async {
      await db.articles.put(article);
      if (scrollPosition?.readingTime != article.readingTime) {
        await db.articleScrollPositions.delete(article.id!);
      }
    });
  }

  Future<void> deleteArticle(int articleId) async {
    await wallabag.deleteEntry(articleId);
    await db.writeTxn(() async {
      await db.articles.delete(articleId);
      await db.articleScrollPositions.delete(articleId);
    });
  }

  Future<void> editArticle(int articleId,
      {bool? archive, bool? starred}) async {
    await wallabag.patchEntry(articleId, archive: archive, starred: starred);
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
