import 'package:logging/logging.dart';

import '../../data/services/local/storage/storage_service.dart';
import '../../server/src/clients/api.dart';
import '../../server/src/clients/api_methods.dart';

typedef ActionParams = Map<String, dynamic>;
typedef ProgressCallback = void Function(double? progress);

abstract class RemoteAction {
  const RemoteAction(this.type, this.key);

  final String key;
  final RemoteActionType type;

  @override
  bool operator ==(Object other) => other is RemoteAction && key == other.key;

  @override
  int get hashCode => key.hashCode;

  ActionParams get params;

  factory RemoteAction.fromParams(String actionTypeName, ActionParams params) {
    final actionType = RemoteActionType.values.byName(actionTypeName);
    return actionType.buildActionFromParams(params);
  }

  Future<dynamic> execute(
    ApiClient api,
    LocalStorageService storage,
    ProgressCallback onProgress,
  );

  @override
  String toString() {
    return '$runtimeType[$key]';
  }
}

typedef ActionBuilder = RemoteAction Function(ActionParams);

enum RemoteActionType {
  refreshArticles,
  deleteArticle,
  editArticle,
  saveArticle,
  refetchArticle;

  ActionBuilder get buildActionFromParams => switch (this) {
    RemoteActionType.refreshArticles => RefreshArticlesAction.fromParams,
    RemoteActionType.deleteArticle => DeleteArticleAction.fromParams,
    RemoteActionType.editArticle => EditArticleAction.fromParams,
    RemoteActionType.saveArticle => SaveArticleAction.fromParams,
    RemoteActionType.refetchArticle => RefetchArticleAction.fromParams,
  };
}

class RefreshArticlesAction extends RemoteAction {
  const RefreshArticlesAction()
    : super(RemoteActionType.refreshArticles, 'refreshArticles');

  static final _log = Logger('sync.refresh');

  @override
  ActionParams get params => {};

  factory RefreshArticlesAction.fromParams(ActionParams params) =>
      const RefreshArticlesAction();

  @override
  Future<void> execute(api, storage, onProgress) async {
    // Incremental refresh with throttling
    final int? since = await storage.getLastSyncTS();
    const int threshold = 60; // seconds
    if (since != null) {
      final now = (DateTime.now().millisecondsSinceEpoch / 1000).toInt();
      final elapsed = now - since;
      if (elapsed < threshold) {
        _log.info(
          'incremental refresh throttled (last: ${elapsed.toStringAsFixed(0)} s)',
        );
        return;
      }
    }

    // Full refresh logic (inline from LocalStorage.fullRefresh)
    final stopwatch = Stopwatch()..start();
    var count = 0;

    final sinceDT = since != null
        ? DateTime.fromMillisecondsSinceEpoch(since * 1000)
        : null;
    _log.info('starting refresh with since=${sinceDT?.toIso8601String()}');

    if (since == null) {
      // Full sync: clear and reload all
      await storage.clear(keepPositions: true);
      _log.info('cleared the local cache (articles and pending actions)');

      final articlesStream = api.listArticles(
        since: sinceDT,
        onProgress: onProgress,
      );
      await for (final articles in articlesStream) {
        await storage.updateAllArticles(articles);
        _log.info('saved ${articles.length} articles to the database');
        count += articles.length;
      }
    } else {
      // Incremental sync: apply operations
      final operations = await api.listOperations(
        since: sinceDT,
        localIds: await storage.getAllArticleIds(),
        onProgress: onProgress,
      );
      for (final op in operations) {
        switch (op.type) {
          case ArticleOpType.created:
          case ArticleOpType.updated:
            final article = await api.getArticle(op.articleId);
            count += await storage.articles.update(article);
          case ArticleOpType.deleted:
            count += await storage.articles.delete(op.articleId);
        }
      }
    }

    // Update sync metadata
    final now = (DateTime.now().millisecondsSinceEpoch / 1000).toInt();
    await storage.setLastSyncTS(now);

    _log.info(
      'completed refresh of $count entries in ${stopwatch.elapsed.inSeconds} s',
    );
  }
}

class DeleteArticleAction extends RemoteAction {
  const DeleteArticleAction(this.articleId)
    : super(RemoteActionType.deleteArticle, 'deleteArticle:$articleId');

  final int articleId;

  @override
  ActionParams get params => {'articleId': articleId};

  factory DeleteArticleAction.fromParams(ActionParams params) =>
      DeleteArticleAction(params['articleId'] as int);

  @override
  Future<void> execute(api, storage, onProgress) async {
    await api.deleteArticle(articleId);
    await storage.articles.delete(articleId);
  }
}

class EditArticleAction extends RemoteAction {
  const EditArticleAction(
    this.articleId, {
    this.archived,
    this.starred,
    this.tags,
  }) : super(
         RemoteActionType.editArticle,
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
  Future<void> execute(api, storage, onProgress) async {
    final article = await api.updateArticle(
      articleId,
      archived: archived,
      starred: starred,
      tags: tags,
    );
    await storage.articles.update(article);
  }
}

class SaveArticleAction extends RemoteAction {
  SaveArticleAction(this.url, {this.tags})
    : super(RemoteActionType.saveArticle, 'saveArticle:$url:$tags');

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
  Future<int> execute(api, storage, onProgress) async {
    final article = await api.createArticle(url.toString(), tags: tags);
    await storage.articles.update(article);

    return article.id;
  }
}

class RefetchArticleAction extends RemoteAction {
  const RefetchArticleAction(this.articleId)
    : super(RemoteActionType.refetchArticle, 'refetchArticle:$articleId');

  final int articleId;

  @override
  ActionParams get params => {'articleId': articleId};

  factory RefetchArticleAction.fromParams(ActionParams params) =>
      RefetchArticleAction(params['articleId'] as int);

  @override
  Future<bool> execute(api, storage, onProgress) async {
    try {
      await api.recrawlArticle(articleId);
      final article = await api.getArticle(articleId);
      await storage.articles.update(article);
      return true;
    } catch (e) {
      return false;
    }
  }
}
