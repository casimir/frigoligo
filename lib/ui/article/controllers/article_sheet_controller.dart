import 'dart:ui';

import '../../../data/services/platform/sharing_service.dart';
import '../../../data/services/platform/urllauncher_service.dart';
import '../../../domain/repositories.dart';
import '../../../services/remote_sync.dart';
import '../../../services/remote_sync_actions.dart';

class ArticleSheetController {
  const ArticleSheetController({
    required RemoteSyncer syncer,
    required TagRepository tagRepository,
    required SharingService sharingService,
    required UrlLauncherService urlLauncherService,
    required this.articleId,
  }) : _syncer = syncer,
       _tagRepository = tagRepository,
       _sharingService = sharingService,
       _urlLauncherService = urlLauncherService;

  final RemoteSyncer _syncer;
  final TagRepository _tagRepository;
  final SharingService _sharingService;
  final UrlLauncherService _urlLauncherService;
  final int articleId;

  Future<List<String>> allTags() => _tagRepository.getAll();

  Future<void> refetchContent() {
    return _syncer
        .add(RefetchArticleAction(articleId))
        .then((_) => _syncer.synchronize());
  }

  Future<void> setTags(List<String> tags) {
    return _syncer
        .add(EditArticleAction(articleId, tags: tags))
        .then((_) => _syncer.synchronize());
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
