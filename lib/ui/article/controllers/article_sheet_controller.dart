import 'dart:ui';

import '../../../data/services/platform/sharing_service.dart';
import '../../../data/services/platform/urllauncher_service.dart';
import '../../../domain/repositories.dart';
import '../../../domain/sync/sync_manager.dart';

class ArticleSheetController {
  const ArticleSheetController({
    required SyncManager syncManager,
    required TagRepository tagRepository,
    required SharingService sharingService,
    required UrlLauncherService urlLauncherService,
    required this.articleId,
  }) : _syncManager = syncManager,
       _tagRepository = tagRepository,
       _sharingService = sharingService,
       _urlLauncherService = urlLauncherService;

  final SyncManager _syncManager;
  final TagRepository _tagRepository;
  final SharingService _sharingService;
  final UrlLauncherService _urlLauncherService;
  final int articleId;

  Future<List<String>> allTags() => _tagRepository.getAll();

  Future<void> refetchContent() async {
    await _syncManager.addAction(RefetchArticleAction(articleId));
    await _syncManager.synchronize(withFinalRefresh: false);
  }

  Future<void> setTags(List<String> tags) async {
    await _syncManager.addAction(EditArticleAction(articleId, tags: tags));
    await _syncManager.synchronize(withFinalRefresh: false);
  }

  Future<void> share(String title, String url, Rect sharePositionOrigin) {
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
