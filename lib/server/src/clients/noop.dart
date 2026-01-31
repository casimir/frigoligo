import 'package:http/http.dart' as http;

import '../../../data/services/local/storage/database/models/article.drift.dart';
import 'api.dart';
import 'api_methods.dart';

/// API client for local/demo mode that doesn't communicate with servers.
///
/// Operations are handled locally via [RemoteAction.onAdd()] before reaching
/// this client. Methods either throw [UnsupportedError] or return minimal data.
class NoOpApiClient extends ApiClient with ApiMethods {
  NoOpApiClient({super.userAgent, super.selfSignedHost, super.enableHttpLogs});

  @override
  Future<Uri> buildUri(String path, [Map<String, dynamic>? queryParameters]) {
    throw UnsupportedError('NoOpApiClient does not support HTTP requests');
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw UnsupportedError('NoOpApiClient does not support HTTP requests');
  }

  @override
  Future<Article> createArticle(String url, {List<String>? tags}) {
    throw UnsupportedError('Cannot create articles in demo mode');
  }

  @override
  Stream<List<Article>> listArticles({
    DateTime? since,
    ApiProgressCallback? onProgress,
  }) async* {
    onProgress?.call(1.0);
  }

  @override
  Future<Article> getArticle(int id) {
    throw UnsupportedError('Cannot fetch articles from server in demo mode');
  }

  @override
  Future<Article> updateArticle(
    int id, {
    bool? archived,
    bool? starred,
    List<String>? tags,
  }) {
    return Future.value(
      Article(
        id: id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        title: '',
        url: '',
        readingTime: 0,
        archivedAt: archived == true ? DateTime.now() : null,
        starredAt: starred == true ? DateTime.now() : null,
        tags: tags ?? [],
      ),
    );
  }

  @override
  Future<ApiActionResult> deleteArticle(int id) {
    return Future.value(ApiActionResult.succeed);
  }

  @override
  Future<ApiActionResult> recrawlArticle(int id) {
    throw UnsupportedError('Cannot refetch articles in demo mode');
  }

  @override
  Future<List<ArticleOperation>> listOperations({
    DateTime? since,
    required Set<int> localIds,
    ApiProgressCallback? onProgress,
  }) async {
    onProgress?.call(1.0);
    return [];
  }
}
