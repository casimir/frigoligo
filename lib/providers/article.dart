import 'dart:async';

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../db/database.dart';
import '../db/models/article.drift.dart';
import '../services/wallabag_storage.dart';
import 'query.dart';
import 'settings.dart';

part 'article.g.dart';

@riverpod
class CurrentArticle extends _$CurrentArticle {
  int? _articleId;
  StreamSubscription? _watcher;

  @override
  Future<Article?> build() async {
    _watcher?.cancel();

    _articleId ??=
        ref.watch(settingsProvider.select((it) => it[Sk.selectedArticleId]));

    if (_articleId != null) {
      _watch();
      final t1 = DB.get().managers.articles;
      return t1.filter((f) => f.id.equals(_articleId!)).getSingleOrNull();
    }

    final query = ref.watch(queryProvider);
    final article = await ref.read(wStorageProvider.notifier).index(0, query);
    if (article != null) {
      _articleId = article.id;
      _watch();
      return article;
    }

    return null;
  }

  void _watch() {
    final q =
        DB.get().managers.articles.filter((f) => f.id.equals(_articleId!));
    _watcher = q.watchSingleOrNull(distinct: false).listen((article) {
      if (article == null) {
        _articleId = null;
        ref.invalidateSelf();
        return;
      }

      final stateArticle = state.maybeWhen(orElse: () => null, data: (a) => a);

      if (stateArticle == null) {
        state = AsyncValue.data(article);
      } else if (article != stateArticle && article.id == stateArticle.id) {
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

    final db = DB.get();
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
    final q = DB
        .get()
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
