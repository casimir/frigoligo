import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/article.dart';
import '../models/article_scroll_position.dart';
import '../models/db.dart';
import '../services/remote_sync.dart';
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
    _articleId ??= ref.read(settingsProvider)[Sk.selectedArticleId];

    if (_articleId != null) {
      return DB.get().articles.get(_articleId!);
    }

    final storage = RemoteSyncer.instance.wallabag;
    if (storage == null) return null;

    final query = ref.read(queryProvider);
    final article = storage.index(0, query);
    if (article != null) {
      _articleId = article.id;
      return article;
    }

    return null;
  }

  void change(int articleId) {
    if (_articleId == articleId) return;

    _articleId = articleId;
    if (!kIsWeb) {
      _watcher?.cancel();
      _watcher = DB.get().articles.watchObjectLazy(articleId).listen((_) {
        ref.invalidateSelf();
      });
    }

    ref.read(settingsProvider)[Sk.selectedArticleId] = articleId;

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
    final article = db.articles.get(_articleId!);
    db.write((db) {
      db.articleScrollPositions.put(
        ArticleScrollPosition.fromArticle(article!, progress),
      );
    });
  }
}
