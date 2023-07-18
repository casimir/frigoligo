import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frigoligo/wallabag/wallabag.dart';

import '../models/article.dart';
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

  Future<void> modifyAndRefresh({
    bool? archive,
    bool? starred,
    Function(double)? onProgress,
  }) async {
    onProgress?.call(0);
    var wallabag = WallabagInstance.get();
    await wallabag.patchEntry(articleId, archive: archive, starred: starred);
    var (entry, _) = await wallabag.getEntry(articleId);
    await db.writeTxn(() async {
      return await db.articles.put(Article.fromWallabagEntry(entry));
    });
    onProgress?.call(1);
  }

  Future<void> deleteAndRefresh() async {
    var wallabag = WallabagInstance.get();
    await wallabag.deleteEntry(articleId);
    await db.writeTxn(() async {
      return await db.articles.delete(articleId);
    });
  }
}
