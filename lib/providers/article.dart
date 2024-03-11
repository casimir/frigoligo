import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/article.dart';
import '../models/article_scroll_position.dart';
import '../models/db.dart';

class ArticleProvider extends ChangeNotifier {
  ArticleProvider(this.articleId) {
    _watcher =
        db.articles.watchObjectLazy(articleId).listen((_) => notifyListeners());
  }

  final DBInstance db = DB.get();
  StreamSubscription? _watcher;
  int articleId;

  Article? get article => db.articles.getSync(articleId);

  @override
  void dispose() {
    _watcher?.cancel();
    super.dispose();
  }

  void updateId(int id) {
    articleId = id;
    _watcher?.cancel();
    _watcher =
        db.articles.watchObjectLazy(articleId).listen((_) => notifyListeners());
  }

  Future<void> saveScrollPosition(double position) async {
    if (articleId == 0) return;
    final article = await db.articles.get(articleId);
    await db.writeTxn(() async {
      await db.articleScrollPositions.put(
        ArticleScrollPosition.fromArticle(article!, position),
      );
    });
  }
}

final scrollPositionProvider =
    FutureProvider.autoDispose.family<ArticleScrollPosition?, int>(
  (ref, articleId) => DB.get().articleScrollPositions.get(articleId),
);
