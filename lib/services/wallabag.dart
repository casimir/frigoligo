import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frigoligo/wallabag/wallabag.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/article.dart';
import '../models/article_scroll_position.dart';
import '../models/db.dart';

final _log = Logger('wallabag.service');

enum RefreshState {
  idle,
  inProgress,
  success,
  error,
}

class ArticlesProvider with ChangeNotifier {
  ArticlesProvider() {
    _watcher = db.articles.watchLazy().listen((_) => notifyListeners());
    if (wallabag.canRefreshToken) {
      if (db.articles.countSync() == 0) {
        fullRefresh();
      } else {
        incrementalRefresh(threshold: autoSyncThrottleSeconds);
      }
    }
  }

  final DBInstance db = DB.get();
  final WallabagClient wallabag = WallabagInstance.get();
  StreamSubscription? _watcher;

  float? _refreshProgressValue;
  float? get refreshProgressValue => _refreshProgressValue;
  set refreshProgressValue(float? value) {
    _refreshProgressValue = value;
    notifyListeners();
  }

  bool get refreshInProgress => _refreshProgressValue != null;

  @override
  void dispose() {
    _watcher?.cancel();
    super.dispose();
  }

  Query<R> _buildQuery<R>({
    StateFilter state = StateFilter.unread,
    StarredFilter starred = StarredFilter.all,
    String? sort,
    String? property,
  }) {
    List<FilterCondition> conditions = [];
    if (state != StateFilter.all) {
      conditions.add(state == StateFilter.archived
          ? const FilterCondition.isNotNull(property: 'archivedAt')
          : const FilterCondition.isNull(property: 'archivedAt'));
    }
    if (starred == StarredFilter.starred) {
      conditions.add(const FilterCondition.isNotNull(property: 'starredAt'));
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

  List<Article> all(StateFilter state, StarredFilter starred) =>
      _buildQuery<Article>(
        state: state,
        starred: starred,
        sort: '-createdAt',
      ).findAllSync();
  Article? index(int n, StateFilter state, StarredFilter starred) {
    if (n < 0 || n >= count(state, starred)) return null;
    var ids = _buildQuery(
      state: state,
      starred: starred,
      sort: '-createdAt',
      property: 'id',
    ).findAllSync();
    return db.articles.getSync(ids[n])!;
  }

  int count(StateFilter state, StarredFilter starred) =>
      _buildQuery(state: state, starred: starred).countSync();

  Future<int> syncRemoteDeletes() async {
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
    await for (final (entries, _) in entriesStream) {
      localIds = localIds.difference(entries.map((e) => e.id).toSet());
    }

    await db.writeTxn(() async {
      await db.articles.deleteAll(localIds.toList());
      await db.articleScrollPositions.deleteAll(localIds.toList());
    });

    return delta;
  }

  Future<int> fullRefresh({int? since}) async {
    assert(!refreshInProgress);

    var count = 0;
    final sinceRepr = since != null
        ? DateTime.fromMillisecondsSinceEpoch(since * 1000).toIso8601String()
        : null;
    _log.info('starting entries refresh from (since: $sinceRepr)');

    if (since == null) {
      await db.writeTxn(() async => await db.articles.clear());
    }

    final stopwatch = Stopwatch()..start();
    var entriesStream = wallabag.fetchAllEntries(
      since: since,
      onProgress: (progress) => refreshProgressValue = progress,
    );
    await for (final (entries, _) in entriesStream) {
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

      await db.writeTxn(() async {
        await db.articles.putAll(articles.values.toList());
        await db.articleScrollPositions.deleteAll(invalidPositions);
      });

      count += entries.length;
    }
    _log.info(
        'completed refresh of $count entries in ${stopwatch.elapsed.inSeconds} s');
    syncRemoteDeletes();

    final now = DateTime.now().millisecondsSinceEpoch / 1000;
    await SharedPreferences.getInstance()
        .then((prefs) => prefs.setInt('lastRefreshTimestamp', now.toInt()));
    refreshProgressValue = null;

    return count;
  }

  Future<int> incrementalRefresh({int? threshold}) async {
    final since = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getInt('lastRefreshTimestamp'));

    if (threshold != null && since != null) {
      final now = DateTime.now().millisecondsSinceEpoch / 1000;
      if (now - since < threshold) return 0;
    }
    return fullRefresh(since: since);
  }
}
