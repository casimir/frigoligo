import 'dart:async';

import 'package:flutter/material.dart';

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
  bool hasJumpedToPosition = false;

  Article? get article => db.articles.getSync(articleId);
  double? get scrollPosition =>
      db.articleScrollPositions.getSync(articleId)?.position;
  bool get isPositionRestorePending =>
      articleId != 0 && !hasJumpedToPosition && scrollPosition != null;

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
    hasJumpedToPosition = false;
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
