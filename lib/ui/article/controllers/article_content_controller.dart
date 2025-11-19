import '../../../domain/repositories.dart';

class ArticleContentController {
  ArticleContentController({
    required ArticleRepository articleRepository,
    required this.articleId,
  }) : _articleRepository = articleRepository;

  final ArticleRepository _articleRepository;
  final int articleId;

  Future<void> setReadingProgress(double progress) async {
    await _articleRepository.setReadingProgress(articleId, progress);
  }
}
