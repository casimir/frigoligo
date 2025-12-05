import 'dart:ui';

import '../../../data/services/platform/sharing_service.dart';
import '../../../data/services/platform/urllauncher_service.dart';
import '../../../services/remote_sync.dart';
import '../../../services/remote_sync_actions.dart';

class ArticleScreenController {
  ArticleScreenController({
    required RemoteSyncer syncer,
    required SharingService sharingService,
    required UrlLauncherService urlLauncherService,
    required this.articleId,
  }) : _syncer = syncer,
       _sharingService = sharingService,
       _urlLauncherService = urlLauncherService;

  final RemoteSyncer _syncer;
  final SharingService _sharingService;
  final UrlLauncherService _urlLauncherService;
  final int articleId;

  Future<void> setArchived(bool archived) {
    return _syncer
        .add(EditArticleAction(articleId, archived: archived))
        .then((_) => _syncer.synchronize());
  }

  Future<void> setStarred(bool starred) {
    return _syncer
        .add(EditArticleAction(articleId, starred: starred))
        .then((_) => _syncer.synchronize());
  }

  Future<void> deleteArticle() {
    return _syncer
        .add(DeleteArticleAction(articleId))
        .then((_) => _syncer.synchronize());
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
