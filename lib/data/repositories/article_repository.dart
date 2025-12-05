import '../../domain/models/article_data.dart';
import '../../domain/repositories.dart';
import '../services/local/storage/storage_service.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  ArticleRepositoryImpl({required LocalStorageService localStorageService})
    : _localStorageService = localStorageService;

  final LocalStorageService _localStorageService;

  @override
  Stream<ArticleData?> watchData(int id) {
    final dataQuery = _localStorageService.articles.getData(id);
    return dataQuery.watchSingleOrNull().map((article) {
      if (article == null) return null;

      return ArticleData(
        id: article.id,
        title: article.title,
        domainName: article.domainName,
        url: article.url,
        hasContent: article.content != null,
        readingTime: article.readingTime,
        previewPicture: article.previewPicture,
        isArchived: article.archivedAt != null,
        isStarred: article.starredAt != null,
        tags: article.tags,
      );
    });
  }

  @override
  Stream<String?> watchContent(int id) {
    return _localStorageService.articles.getContent(id).watchSingleOrNull();
  }

  @override
  Stream<double?> watchReadingProgress(int id) {
    return _localStorageService.articles
        .getReadingProgress(id)
        .watchSingleOrNull();
  }

  @override
  Future<void> setReadingProgress(int id, double progress) {
    return _localStorageService.articles.setReadingProgress(id, progress);
  }
}
