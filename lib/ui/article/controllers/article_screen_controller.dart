import 'dart:ui';

import '../../../data/services/platform/sharing_service.dart';
import '../../../data/services/platform/urllauncher_service.dart';
import '../../../domain/sync/sync_manager.dart';

class ArticleScreenController {
  ArticleScreenController({
    required SyncManager syncManager,
    required SharingService sharingService,
    required UrlLauncherService urlLauncherService,
    required this.articleId,
  }) : _syncManager = syncManager,
       _sharingService = sharingService,
       _urlLauncherService = urlLauncherService;

  final SyncManager _syncManager;
  final SharingService _sharingService;
  final UrlLauncherService _urlLauncherService;
  final int articleId;

  Future<void> setArchived(bool archived) async {
    await _syncManager.addAction(
      EditArticleAction(articleId, archived: archived),
    );
    await _syncManager.synchronize(withFinalRefresh: false);
  }

  Future<void> setStarred(bool starred) async {
    await _syncManager.addAction(
      EditArticleAction(articleId, starred: starred),
    );
    await _syncManager.synchronize(withFinalRefresh: false);
  }

  Future<void> deleteArticle() async {
    await _syncManager.addAction(DeleteArticleAction(articleId));
    await _syncManager.synchronize(withFinalRefresh: false);
  }

  Future<void> shareArticle(
    String title,
    String url,
    Rect sharePositionOrigin,
  ) {
    return _sharingService.shareAsText(
      title,
      url,
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  Future<void> openInBrowser(Uri url) {
    return _urlLauncherService.launch(url);
  }
}
