import '../../../db/models/article.drift.dart';

mixin ApiMethods {
  /// Create a new article.
  Future<Article> createArticle(String url, {List<String>? tags});

  /// List all articles. When [since] is provided, only articles updated since
  /// that timestamp will be returned.
  ///
  /// [onProgress] will be called with the progress of the page enumeration
  /// in case of pagination.
  Stream<List<Article>> listArticles({
    DateTime? since,
    ApiProgressCallback? onProgress,
  });

  /// Retrieve an article using its ID.
  Future<Article> getArticle(int id);

  /// Update the article attributes.
  Future<Article> updateArticle(
    int id, {
    bool? archived,
    bool? starred,
    List<String>? tags,
  });

  /// Delete the article.
  Future<ApiActionResult> deleteArticle(int id);

  /// Trigger a new fetch of the article from the original source.
  Future<ApiActionResult> recrawlArticle(int id);

  /// List all operations on articles since a given point in time.
  ///
  /// [localIds] is an exhaustive list of the IDs of the local articles so that
  /// backends that don't support deletion enumeration can compute on the fly.
  ///
  /// [onProgress] will be called with the progress of the page enumeration
  /// in case of pagination.
  ///
  /// The intended use of this method is to provide a way to compute state sync
  /// delta as efficiently as possible. So, this method should reduce back and
  /// forth between the server and the client and payload size should be minimized.
  Future<List<ArticleOperation>> listOperations({
    DateTime? since,
    required Set<int> localIds,
    ApiProgressCallback? onProgress,
  });
}

enum ApiActionResult { accepted, succeed, failed }

/// A callback that will be called with the server-side progress (0.0 to 1.0).
typedef ApiProgressCallback = void Function(double);

class ArticleOperation {
  const ArticleOperation({
    required this.articleId,
    required this.type,
    required this.performedAt,
  });

  final int articleId;
  final DateTime performedAt;
  final ArticleOpType type;
}

enum ArticleOpType { created, updated, deleted }
