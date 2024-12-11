import 'dart:async';

import 'package:drift/drift.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants.dart';
import '../db/database.dart';
import '../db/models/article.drift.dart';
import 'query.dart';
import 'settings.dart';

part 'article.g.dart';

final _log = Logger('providers.article');

@riverpod
class ArticleData extends _$ArticleData {
  StreamSubscription? _watcher;

  @override
  Future<Article?> build(int articleId) async {
    final stopwatch = Stopwatch()..start();
    _watcher?.cancel();
    _watch(articleId);
    final t1 = DB().managers.articles;
    final ret =
        await t1.filter((f) => f.id.equals(articleId)).getSingleOrNull();
    if (enablePerfLogs) {
      _log.info(
          'perf: ArticleData.build($articleId): ${stopwatch.elapsedMilliseconds} ms');
    }
    return ret;
  }

  void _watch(int articleId) {
    final q = DB().managers.articles.filter((f) => f.id.equals(articleId));
    _watcher = q.watchSingleOrNull(distinct: false).listen((article) {
      final stateArticle = state.maybeWhen(orElse: () => null, data: (a) => a);
      if (stateArticle == null || article != stateArticle) {
        state = AsyncValue.data(article);
      }
    });
    ref.onDispose(() => _watcher?.cancel());
  }

  Future<void> saveScrollProgress(double progress) async {
    final article = state.maybeWhen(orElse: () => null, data: (a) => a);
    if (article == null) return;

    await DB().managers.articleScrollPositions.create(
          (o) => o(
            id: Value(article.id),
            readingTime: article.readingTime,
            progress: progress,
          ),
          mode: InsertMode.insertOrReplace,
        );
  }
}

@riverpod
class CurrentArticle extends _$CurrentArticle {
  int? _articleId;
  StreamSubscription? _watcher;

  @override
  Future<Article?> build() async {
    _watcher?.cancel();

    _articleId ??=
        ref.watch(settingsProvider.select((it) => it[Sk.selectedArticleId]));

    if (_articleId == null) {
      final meta = await ref.read(queryMetaProvider.future);
      if (meta.ids.isNotEmpty) {
        _articleId = meta.ids.first;
      }
    }

    if (_articleId != null) {
      _watch();
      return ref.watch(articleDataProvider(_articleId!).future);
    }

    return null;
  }

  void _watch() {
    final q = DB().managers.articles.filter((f) => f.id.equals(_articleId!));
    _watcher = q.watchSingleOrNull(distinct: false).listen((article) {
      if (article == null) {
        _articleId = null;
        ref.invalidateSelf();
        return;
      }

      final stateArticle = state.maybeWhen(orElse: () => null, data: (a) => a);
      if (stateArticle == null) {
        state = AsyncValue.data(article);
      } else if (article.id != stateArticle.id) {
        change(article.id);
      }
    });
    ref.onDispose(() => _watcher?.cancel());
  }

  void change(int articleId) {
    if (_articleId == articleId) return;

    _articleId = articleId;

    ref.read(settingsProvider.notifier).set(Sk.selectedArticleId, articleId);
    ref.invalidateSelf();
  }

  bool maybeInit(int articleId) {
    if (_articleId != null && _articleId! > 0) return false;

    change(articleId);
    return true;
  }

  Future<void> saveScrollProgress(double progress) async {
    if (_articleId == null) return;

    final db = DB();
    final article = await db.managers.articles
        .filter(
          (f) => f.id.equals(_articleId!),
        )
        .getSingle();
    await db.managers.articleScrollPositions.create(
      (o) => o(
        id: Value(article.id),
        readingTime: article.readingTime,
        progress: progress,
      ),
      mode: InsertMode.insertOrReplace,
    );
  }
}

@riverpod
class ScrollPosition extends _$ScrollPosition {
  StreamSubscription? _watcher;

  @override
  Future<ArticleScrollPosition?> build(int articleId) {
    final q = DB()
        .managers
        .articleScrollPositions
        .filter((f) => f.id.equals(articleId));

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
