import 'base.dart';

class RefreshArticlesAction extends RemoteSyncAction {
  const RefreshArticlesAction() : super('refreshArticles');

  @override
  ActionParams params() => {};

  factory RefreshArticlesAction.fromParams(ActionParams params) =>
      const RefreshArticlesAction();

  @override
  Future<void> execute(syncer, storage) async {
    await storage.incrementalRefresh(
      onProgress: (progress) => syncer.setProgress(progress),
    );
  }
}

class DeleteArticleAction extends RemoteSyncAction {
  const DeleteArticleAction(this.articleId) : super('deleteArticle:$articleId');

  final int articleId;

  @override
  ActionParams params() => {'articleId': articleId};

  factory DeleteArticleAction.fromParams(ActionParams params) =>
      DeleteArticleAction(params['articleId'] as int);

  @override
  Future<void> execute(syncer, storage) => storage.deleteArticle(articleId);
}

class EditArticleAction extends RemoteSyncAction {
  const EditArticleAction(
    this.articleId, {
    this.archive,
    this.starred,
    this.tags,
  }) : super('patchArticle:$articleId:$archive:$starred:$tags');

  final int articleId;
  final bool? archive;
  final bool? starred;
  final List<String>? tags;

  @override
  ActionParams params() => {
        'articleId': articleId,
        'archive': archive,
        'starred': starred,
        'tags': tags,
      };

  factory EditArticleAction.fromParams(ActionParams params) =>
      EditArticleAction(
        params['articleId'] as int,
        archive: params['archive'] as bool?,
        starred: params['starred'] as bool?,
        tags: (params['tags'] as List?)?.cast<String>(),
      );

  @override
  Future<void> execute(syncer, storage) => storage.editArticle(articleId,
      archive: archive, starred: starred, tags: tags);
}
