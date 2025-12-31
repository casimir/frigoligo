import '../../../domain/repositories.dart';
import '../../../domain/managers/sync_manager.dart';
import '../../../services/remote_sync_actions.dart';

class ArticleEntryController {
  const ArticleEntryController({
    required QueryRepository queryRepository,
    required SyncManager syncManager,
    required this.articleId,
  }) : _queryRepository = queryRepository,
       _syncManager = syncManager;

  final QueryRepository _queryRepository;
  final SyncManager _syncManager;
  final int articleId;

  void changeTagsSearchFilterTo(String tag) {
    _queryRepository.query = _queryRepository.query.copyWith(tags: [tag]);
  }

  Future<void> setArchived(bool archived) async {
    await _syncManager.addAction(EditArticleAction(articleId, archived: archived));
    await _syncManager.synchronize(withFinalRefresh: false);
  }

  Future<void> setStarred(bool starred) async {
    await _syncManager.addAction(EditArticleAction(articleId, starred: starred));
    await _syncManager.synchronize(withFinalRefresh: false);
  }
}
