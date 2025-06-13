import 'local_storage.dart';
import 'remote_sync.dart';

typedef ActionParams = Map<String, dynamic>;

abstract class RemoteSyncAction {
  const RemoteSyncAction(this.type, this.key);

  final String key;
  final RemoteSyncActionType type;

  @override
  bool operator ==(Object other) =>
      other is RemoteSyncAction && key == other.key;

  @override
  int get hashCode => key.hashCode;

  ActionParams get params;

  factory RemoteSyncAction.fromParams(
    String actionTypeName,
    ActionParams params,
  ) {
    final actionType = RemoteSyncActionType.values.byName(actionTypeName);
    return actionType.buildActionFromParams(params);
  }

  Future<dynamic> execute(RemoteSyncer syncer, LocalStorage storage);

  @override
  String toString() {
    return '$runtimeType[$key]';
  }
}

typedef ActionBuilder = RemoteSyncAction Function(ActionParams);

enum RemoteSyncActionType {
  refreshArticles,
  deleteArticle,
  editArticle,
  saveArticle,
  refetchArticle;

  ActionBuilder get buildActionFromParams => switch (this) {
    RemoteSyncActionType.refreshArticles => RefreshArticlesAction.fromParams,
    RemoteSyncActionType.deleteArticle => DeleteArticleAction.fromParams,
    RemoteSyncActionType.editArticle => EditArticleAction.fromParams,
    RemoteSyncActionType.saveArticle => SaveArticleAction.fromParams,
    RemoteSyncActionType.refetchArticle => RefetchArticleAction.fromParams,
  };
}

class RefreshArticlesAction extends RemoteSyncAction {
  const RefreshArticlesAction()
    : super(RemoteSyncActionType.refreshArticles, 'refreshArticles');

  @override
  ActionParams get params => {};

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
  const DeleteArticleAction(this.articleId)
    : super(RemoteSyncActionType.deleteArticle, 'deleteArticle:$articleId');

  final int articleId;

  @override
  ActionParams get params => {'articleId': articleId};

  factory DeleteArticleAction.fromParams(ActionParams params) =>
      DeleteArticleAction(params['articleId'] as int);

  @override
  Future<void> execute(syncer, storage) => storage.deleteArticle(articleId);
}

class EditArticleAction extends RemoteSyncAction {
  const EditArticleAction(
    this.articleId, {
    this.archived,
    this.starred,
    this.tags,
  }) : super(
         RemoteSyncActionType.editArticle,
         'patchArticle:$articleId:$archived:$starred:$tags',
       );

  final int articleId;
  final bool? archived;
  final bool? starred;
  final List<String>? tags;

  @override
  ActionParams get params => {
    'articleId': articleId,
    'archived': archived,
    'starred': starred,
    'tags': tags,
  };

  factory EditArticleAction.fromParams(ActionParams params) =>
      EditArticleAction(
        params['articleId'] as int,
        archived: params['archived'] as bool?,
        starred: params['starred'] as bool?,
        tags: (params['tags'] as List?)?.cast<String>(),
      );

  @override
  Future<void> execute(syncer, storage) => storage.editArticle(
    articleId,
    archived: archived,
    starred: starred,
    tags: tags,
  );
}

class SaveArticleAction extends RemoteSyncAction {
  SaveArticleAction(this.url, {this.tags})
    : super(RemoteSyncActionType.saveArticle, 'saveArticle:$url:$tags');

  final Uri url;
  final List<String>? tags;

  @override
  ActionParams get params => {'url': url.toString(), 'tags': tags};

  factory SaveArticleAction.fromParams(ActionParams params) =>
      SaveArticleAction(
        Uri.parse(params['url'] as String),
        tags: (params['tags'] as List?)?.cast<String>(),
      );

  @override
  Future<int> execute(syncer, storage) =>
      storage.saveArticle(url.toString(), tags: tags);
}

class RefetchArticleAction extends RemoteSyncAction {
  const RefetchArticleAction(this.articleId)
    : super(RemoteSyncActionType.refetchArticle, 'refetchArticle:$articleId');

  final int articleId;

  @override
  ActionParams get params => {'articleId': articleId};

  factory RefetchArticleAction.fromParams(ActionParams params) =>
      RefetchArticleAction(params['articleId'] as int);

  @override
  Future<bool> execute(syncer, storage) => storage.refetchArticle(articleId);
}
