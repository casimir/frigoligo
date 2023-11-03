import 'base.dart';

class RefreshArticlesAction extends RemoteSyncAction {
  const RefreshArticlesAction() : super('refreshArticles');

  @override
  Future<void> execute(syncer) async {
    await syncer.wallabag!.incrementalRefresh(
      onProgress: (progress) => syncer.progressValue = progress,
    );
  }
}

class ClearArticlesAction extends RemoteSyncAction {
  const ClearArticlesAction() : super('clearArticles');

  @override
  Future<void> execute(syncer) async {
    await syncer.wallabag!.clearArticles();
  }
}

class DeleteArticleAction extends RemoteSyncAction {
  const DeleteArticleAction(this.articleId) : super('deleteArticle:$articleId');

  final int articleId;

  @override
  Future<void> execute(syncer) async {
    await syncer.wallabag!.deleteArticle(articleId);
  }
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
  Future<void> execute(syncer) async {
    await syncer.wallabag!
        .editArticle(articleId, archive: archive, starred: starred, tags: tags);
  }
}
