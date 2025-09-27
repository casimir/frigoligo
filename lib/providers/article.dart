import 'dart:async';

import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/dependencies.dart';
import '../constants.dart';
import '../data/services/local/storage/database/models/article.drift.dart';
import '../data/services/local/storage/storage_service.dart';
import 'query.dart';
import 'settings.dart';

part '_g/article.g.dart';

final _log = Logger('providers.article');

@riverpod
class ArticleData extends _$ArticleData {
  StreamSubscription? _watcher;

  @override
  Future<Article?> build(int articleId) async {
    final stopwatch = Stopwatch()..start();

    _watcher?.cancel();
    _watch(articleId);
    ref.onDispose(() => _watcher?.cancel());

    final LocalStorageService storageService = dependencies.get();
    final t1 = storageService.db.managers.articles;
    final ret =
        await t1.filter((f) => f.id.equals(articleId)).getSingleOrNull();
    if (enablePerfLogs) {
      _log.info(
        'perf: ArticleData.build($articleId): ${stopwatch.elapsedMilliseconds} ms',
      );
    }
    return ret;
  }

  void _watch(int articleId) {
    final LocalStorageService storageService = dependencies.get();
    final q = storageService.db.managers.articles.filter(
      (f) => f.id.equals(articleId),
    );
    _watcher = q.watchSingleOrNull(distinct: false).listen((article) {
      if (state.isLoading || !state.hasValue) return;
      final stateArticle = state.value;
      if (stateArticle == null || article != stateArticle) {
        state = AsyncValue.data(article);
      }
    });
  }
}

@riverpod
class CurrentArticle extends _$CurrentArticle {
  StreamSubscription? _watcher;

  @override
  Future<Article?> build() async {
    _watcher?.cancel();

    var articleId = ref.watch(
      settingsProvider.select((it) => it[Sk.selectedArticleId]),
    );

    if (articleId != null) {
      final LocalStorageService storageService = dependencies.get();
      final db = storageService.db;
      final exists =
          await db.managers.articles
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
    if (state.value?.id != articleId) {
      ref.read(settingsProvider.notifier).set(Sk.selectedArticleId, articleId);
    }
  }
}

@riverpod
class ScrollPosition extends _$ScrollPosition {
  StreamSubscription? _watcher;

  @override
  Future<ArticleScrollPosition?> build(int articleId) {
    final LocalStorageService storageService = dependencies.get();
    final q = storageService.db.managers.articleScrollPositions.filter(
      (f) => f.id.equals(articleId),
    );

    _watcher?.cancel();
    _watcher = q.watchSingleOrNull().listen((value) {
      final current = state.maybeWhen(orElse: () => null, data: (asp) => asp);
      if (value != current) state = AsyncValue.data(value);
    });

    return q.getSingleOrNull();
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
