import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';

import '../../data/services/local/storage/storage_service.dart';
import '../../server/src/clients/api.dart';
import '../../server/src/clients/api_methods.dart';

typedef ActionParams = Map<String, dynamic>;
typedef ProgressCallback = void Function(double? progress);

abstract class RemoteAction with EquatableMixin {
  const RemoteAction(this.type);

  final RemoteActionType type;

  @override
  List<Object> get props => [key];

  String get key {
    if (params.isEmpty) return type.name;

    // Map defaults to LinkedHashMap, iterations follow insertion order
    final values = params.values.map((v) => v?.toString() ?? 'null').join(':');
    return '${type.name}:$values';
  }

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
  refetchArticle,
  noop;

  ActionBuilder get buildActionFromParams => switch (this) {
    RemoteActionType.refreshArticles => RefreshArticlesAction.fromParams,
    RemoteActionType.deleteArticle => DeleteArticleAction.fromParams,
    RemoteActionType.editArticle => EditArticleAction.fromParams,
    RemoteActionType.saveArticle => SaveArticleAction.fromParams,
    RemoteActionType.refetchArticle => RefetchArticleAction.fromParams,
    RemoteActionType.noop => NoopAction.fromParams,
  };
}

class RefreshArticlesAction extends RemoteAction {
  const RefreshArticlesAction() : super(RemoteActionType.refreshArticles);

  static final _log = Logger('sync.refresh');

  @override
  ActionParams get params => {};

  factory RefreshArticlesAction.fromParams(ActionParams params) =>
      const RefreshArticlesAction();

  @override
  Future<void> execute(api, storage, onProgress) async {
    final int? since = await storage.metadata.getLastSyncTS();
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

    final stopwatch = Stopwatch()..start();
    var count = 0;

    final sinceDT = since != null
        ? DateTime.fromMillisecondsSinceEpoch(since * 1000)
        : null;
    _log.info('starting refresh with since=${sinceDT?.toIso8601String()}');

    if (since == null) {
      await storage.database.clear(keepPositions: true);
      _log.info('cleared the local cache (articles and pending actions)');

      final articlesStream = api.listArticles(
        since: sinceDT,
        onProgress: onProgress,
      );
      await for (final articles in articlesStream) {
        await storage.articles.updateAll(articles);
        _log.info('saved ${articles.length} articles to the database');
        count += articles.length;
      }
    } else {
      final operations = await api.listOperations(
        since: sinceDT,
        localIds: await storage.articles.getAllIds(),
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

    final now = (DateTime.now().millisecondsSinceEpoch / 1000).toInt();
    await storage.metadata.setLastSyncTS(now);

    _log.info(
      'completed refresh of $count entries in ${stopwatch.elapsed.inSeconds} s',
    );
  }
}

class DeleteArticleAction extends RemoteAction {
  const DeleteArticleAction(this.articleId)
    : super(RemoteActionType.deleteArticle);

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
  }) : super(RemoteActionType.editArticle);

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
    : super(RemoteActionType.saveArticle);

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
    : super(RemoteActionType.refetchArticle);

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

class NoopAction extends RemoteAction {
  const NoopAction(this.value) : super(RemoteActionType.noop);

  final String value;

  @override
  ActionParams get params => {'value': value};

  factory NoopAction.fromParams(ActionParams params) =>
      NoopAction(params['value'] as String);

  factory NoopAction.error(Object error) =>
      NoopAction('ERROR:${error.runtimeType}:$error');

  @override
  Future<void> execute(api, storage, onProgress) async {
    if (value.startsWith('ERROR:')) {
      final parts = value.split(':');
      final type = parts[1];
      final message = parts.sublist(2).join(':');

      if (type == 'ServerError') {
        throw ServerError(message);
      } else if (type.contains('ClientException')) {
        throw ServerError(message, source: ClientException(message));
      } else {
        throw Exception(message);
      }
    }
  }
}
