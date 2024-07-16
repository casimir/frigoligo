import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/article.dart';
import '../models/article_scroll_position.dart';
import '../models/db.dart';
import '../services/wallabag_storage.dart';
import 'query.dart';
import 'settings.dart';

part 'article.g.dart';

final scrollPositionProvider =
    FutureProvider.autoDispose.family<ArticleScrollPosition?, int>(
  (ref, articleId) => DB.get().articleScrollPositions.get(articleId),
);

@riverpod
class CurrentArticle extends _$CurrentArticle {
  int? _articleId;
  StreamSubscription? _watcher;

  @override
  Article? build() {
    _articleId ??=
        ref.watch(settingsProvider.select((it) => it[Sk.selectedArticleId]));

    if (_articleId != null) {
      return DB.get().articles.getSync(_articleId!);
    }

    final query = ref.watch(queryProvider);
    final article = ref.read(wStorageProvider.notifier).index(0, query);
    if (article != null) {
      _articleId = article.id;
      return article;
    }

    return null;
  }

  void change(int articleId) {
    if (_articleId == articleId) return;

    _articleId = articleId;
    _watcher?.cancel();
    _watcher = DB.get().articles.watchObjectLazy(articleId).listen((_) {
      ref.invalidateSelf();
    });

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
    final article = await db.articles.get(_articleId!);
    await db.writeTxn(() async {
      await db.articleScrollPositions.put(
        ArticleScrollPosition.fromArticle(article!, progress),
      );
    });
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
