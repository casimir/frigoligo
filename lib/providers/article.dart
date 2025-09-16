import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants.dart';
import '../db/database.dart';
import '../db/models/article.drift.dart';
import 'query.dart';
import 'settings.dart';

part '_g/article.g.dart';

final _log = Logger('providers.article');

// workaround: provider can't return generated types since riverpod 3.0
class ArticleModel {
  ArticleModel({required this.article});

  final Article article;
}

@riverpod
class ArticleData extends _$ArticleData {
  StreamSubscription? _watcher;

  @override
  Future<ArticleModel?> build(int articleId) async {
    final stopwatch = Stopwatch()..start();

    _watcher?.cancel();
    _watch(articleId);
    ref.onDispose(() => _watcher?.cancel());

    final t1 = DB().managers.articles;
    final ret = await t1
        .filter((f) => f.id.equals(articleId))
        .getSingleOrNull();
    if (enablePerfLogs) {
      _log.info(
        'perf: ArticleData.build($articleId): ${stopwatch.elapsedMilliseconds} ms',
      );
    }
    return ret != null ? ArticleModel(article: ret) : null;
  }

  void _watch(int articleId) {
    final q = DB().managers.articles.filter((f) => f.id.equals(articleId));
    _watcher = q.watchSingleOrNull(distinct: false).listen((article) {
      if (state.isLoading || !state.hasValue) return;
      final stateArticle = state.value;
      if (stateArticle == null || article != stateArticle.article) {
        state = AsyncValue.data(
          article != null ? ArticleModel(article: article) : null,
        );
      }
    });
  }
}

@riverpod
class CurrentArticle extends _$CurrentArticle {
  StreamSubscription? _watcher;

  @override
  Future<ArticleModel?> build() async {
    _watcher?.cancel();

    var articleId = ref.watch(
      settingsProvider.select((it) => it[Sk.selectedArticleId]),
    );

    if (articleId != null) {
      final db = DB();
      final exists = await db.managers.articles
          .filter((f) => f.id.equals(articleId))
          .exists();
      if (!exists) {
        articleId = null;
      }
    }

    if (articleId == null) {
      final meta = await ref.read(queryMetaProvider.future);
      if (meta.ids.isNotEmpty) {
        articleId = meta.ids.first;
      } else {
        _waitForArticles(meta);
        return null;
      }
    }

    return articleId != null
        ? ref.watch(articleDataProvider(articleId!).future)
        : null;
  }

  void _waitForArticles(QueryState qs) {
    ref.onDispose(() => _watcher?.cancel());
    _watcher = qs.idsQuery.watch().listen((ids) {
      if (ids.isNotEmpty) {
        ref.invalidateSelf();
      }
    });
  }

  void change(int articleId) {
    if (state.value?.article.id != articleId) {
      ref.read(settingsProvider.notifier).set(Sk.selectedArticleId, articleId);
    }
  }
}

// workaround: provider can't return generated types since riverpod 3.0
class ArticleScrollPositionModel {
  ArticleScrollPositionModel({required this.articleScrollPosition});

  final ArticleScrollPosition articleScrollPosition;
}

@riverpod
class ScrollPosition extends _$ScrollPosition {
  StreamSubscription? _watcher;

  @override
  Future<ArticleScrollPositionModel?> build(int articleId) async {
    final q = DB().managers.articleScrollPositions.filter(
      (f) => f.id.equals(articleId),
    );

    ref.onDispose(() => _watcher?.cancel());
    _watcher?.cancel();
    _watcher = q.watchSingleOrNull().listen((value) {
      final current = state.maybeWhen(orElse: () => null, data: (asp) => asp);
      if (value != current?.articleScrollPosition) {
        state = AsyncValue.data(
          value != null
              ? ArticleScrollPositionModel(articleScrollPosition: value)
              : null,
        );
      }
    });

    final ret = await q.getSingleOrNull();
    return ret != null
        ? ArticleScrollPositionModel(articleScrollPosition: ret)
        : null;
  }
}

@riverpod
class OpenArticle extends _$OpenArticle {
  @override
  int? build() => null;

  void schedule(int articleId) {
    state = articleId;
  }

  void reset() {
    state = null;
  }
}

@riverpod
class CurrentReadingProgress extends _$CurrentReadingProgress {
  @override
  double? build() => null;

  set progress(double value) => state = value;
}
