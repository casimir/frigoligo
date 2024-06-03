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
import '../models/remote_action.dart';
import '../providers/settings.dart';
import '../wallabag/wallabag.dart';

final _log = Logger('wallabag.storage');

class WallabagStorage with ChangeNotifier {
  WallabagStorage(this.settings) {
    if (!kIsWeb) {
      _watcher = db.articles.watchLazy().listen((_) => notifyListeners());
    }
  }

  final DBInstance db = DB.get();
  final WallabagClient wallabag = WallabagInstance.get();
  StreamSubscription? _watcher;
  final SettingsValues settings;

  @override
  void dispose() {
    _watcher?.cancel();
    super.dispose();
  }

  IsarQuery<R> _buildQuery<R>(WQuery wq, {String? sort, String? property}) {
    List<Filter> filters = [];
    if (wq.state != null && wq.state != StateFilter.all) {
      final propertyIdx = db.articles.schema.getPropertyIndex('archivedAt');
      filters.add(wq.state == StateFilter.archived
          ? NotGroup(IsNullCondition(property: propertyIdx))
          : IsNullCondition(property: propertyIdx));
    }
    if (wq.starred == StarredFilter.starred) {
      final propertyIdx = db.articles.schema.getPropertyIndex('starredAt');
      filters.add(NotGroup(IsNullCondition(property: propertyIdx)));
    }

    if (wq.tags != null) {
      final propertyIdx = db.articles.schema.getPropertyIndex('tags');
      if (wq.tags!.length == 1) {
        filters
            .add(ContainsCondition(property: propertyIdx, value: wq.tags![0]));
      } else {
        final tagFilters = OrGroup(wq.tags!
            .map((tag) => ContainsCondition(property: propertyIdx, value: tag))
            .toList());
        filters.add(tagFilters);
      }
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
      final propertyIdx = db.articles.schema.getPropertyIndex(property);
      sortBy.add(SortProperty(property: propertyIdx, sort: direction));
    }

    final propertiesIdx = property != null
        ? [db.articles.schema.getPropertyIndex(property)]
        : null;
    return db.articles.buildQuery(
      filter: AndGroup(filters),
      sortBy: sortBy,
      properties: propertiesIdx,
    );
  }

  List<Article> all(WQuery wq) =>
      _buildQuery<Article>(wq, sort: '-createdAt').findAll();

  Article? index(int n, WQuery wq) {
    if (n < 0 || n >= count(wq)) return null;
    final ids = _buildQuery(wq, sort: '-createdAt', property: 'id').findAll();
    return db.articles.get(ids[n])!;
  }

  int? indexOf(int articleId, WQuery wq) {
    if (articleId <= 0) return null;
    final ids = _buildQuery(wq, sort: '-createdAt', property: 'id').findAll();
    final index = ids.indexOf(articleId);
    return index >= 0 ? index : null;
  }

  int count(WQuery wq) => _buildQuery(wq).count();

  List<String> get tags {
    var tags = db.articles
        .where()
        .tagsProperty()
        .findAll()
        .expand((it) => it)
        .toSet()
        .toList();
    tags.sort();
    return tags;
  }

  Future<int> _syncRemoteDeletes() async {
    _log.info('checking for server-side deletions');
    final remoteCount = await wallabag.fetchTotalEntriesCount();
    var localIds = (db.articles.where().idProperty().findAll()).toSet();
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

    final deletedCount = db.write((db) {
      final res = db.articles.deleteAll(localIds.toList());
      db.articleScrollPositions.deleteAll(localIds.toList());
      return res;
    });
    _log.info('removed $deletedCount entries from database');

    return deletedCount;
  }

  Future<void> updateAppBadge() async {
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
    db.write((db) {
      db.articles.clear();
      if (!keepPositions) db.articleScrollPositions.clear();
      db.remoteActions.clear();
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

    final stopwatch = Stopwatch()..start();
    var entriesStream =
        wallabag.fetchAllEntries(since: since, onProgress: onProgress);
    await for (final entries in entriesStream) {
      final articles = {
        for (var e in entries) e.id: Article.fromWallabagEntry(e)
      };
      final positions =
          db.articleScrollPositions.getAll(articles.keys.toList());
      final invalidPositions = positions
          .whereType<ArticleScrollPosition>()
          .where((e) => e.readingTime != articles[e.id]?.readingTime)
          .map((e) => e.id)
          .toList();

      final putCount = db.write((db) {
        db.articles.putAll(articles.values.toList());
        db.articleScrollPositions.deleteAll(invalidPositions);
        return articles.length;
      });
      _log.info('saved $putCount entries to the database');

      count += entries.length;
    }
    _log.info(
        'completed refresh of $count entries in ${stopwatch.elapsed.inSeconds} s');

    final now = DateTime.now().millisecondsSinceEpoch / 1000;
    settings[Sk.lastRefresh] = now.toInt();

    _syncRemoteDeletes();

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

  void persistArticle(Article article) {
    final scrollPosition = db.articleScrollPositions.get(article.id);
    db.write((db) {
      db.articles.put(article);
      if (scrollPosition?.readingTime != article.readingTime) {
        db.articleScrollPositions.delete(article.id);
      }
    });
  }

  Future<void> deleteArticle(int articleId) async {
    await wallabag.deleteEntry(articleId);
    db.write((db) {
      db.articles.delete(articleId);
      db.articleScrollPositions.delete(articleId);
    });
  }

  Future<void> editArticle(
    int articleId, {
    bool? archive,
    bool? starred,
    List<String>? tags,
  }) async {
    await wallabag.patchEntry(
      articleId,
      archive: archive,
      starred: starred,
      tags: tags,
    );
    final entry = await wallabag.getEntry(articleId);
    final article = Article.fromWallabagEntry(entry);
    persistArticle(article);
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
