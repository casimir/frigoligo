import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frigoligo/wallabag/wallabag.dart';

import '../models/article.dart';
import '../models/db.dart';
import '../models/article_scroll_position.dart';

class ArticleProvider extends ChangeNotifier {
  ArticleProvider(this.articleId) {
    _watcher =
        db.articles.watchObjectLazy(articleId).listen((_) => notifyListeners());
  }

  final DBInstance db = DB.get();
  StreamSubscription? _watcher;
  int articleId;
  bool hasJumpedToPosition = false;

  Article? get article => db.articles.get(articleId);
  double? get scrollPosition =>
      db.articleScrollPositions.get(articleId)?.position;
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

  Future<void> modifyAndRefresh({
    bool? archive,
    bool? starred,
    Function(double)? onProgress,
  }) async {
    onProgress?.call(0);
    var wallabag = WallabagInstance.get();
    await wallabag.patchEntry(articleId, archive: archive, starred: starred);
    final entry = await wallabag.getEntry(articleId);
    final article = Article.fromWallabagEntry(entry);
    final scrollPosition = db.articleScrollPositions.get(articleId);
    db.write((db) {
      db.articles.put(article);
      if (scrollPosition?.readingTime != article.readingTime) {
        db.articleScrollPositions.delete(articleId);
      }
    });
    onProgress?.call(1);
  }

  Future<void> delete() async {
    var wallabag = WallabagInstance.get();
    await wallabag.deleteEntry(articleId);
    db.write((db) {
      db.articles.delete(articleId);
      db.articleScrollPositions.delete(articleId);
    });
  }

  Future<void> saveScrollPosition(double position) async {
    if (articleId == 0) return;
    final article = db.articles.get(articleId);
    db.write((db) {
      db.articleScrollPositions.put(
        ArticleScrollPosition.fromArticle(article!, position),
      );
    });
  }
}
