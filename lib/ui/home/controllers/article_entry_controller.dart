import '../../../domain/repositories.dart';
import '../../../services/remote_sync.dart';
import '../../../services/remote_sync_actions.dart';

class ArticleEntryController {
  const ArticleEntryController({
    required QueryRepository queryRepository,
    required RemoteSyncer syncer,
    required this.articleId,
  }) : _queryRepository = queryRepository,
       _syncer = syncer;

  final QueryRepository _queryRepository;
  final RemoteSyncer _syncer;
  final int articleId;

  void changeTagsSearchFilterTo(String tag) {
    _queryRepository.query = _queryRepository.query.copyWith(tags: [tag]);
  }

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
}
