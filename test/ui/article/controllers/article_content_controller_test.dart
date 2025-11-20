import 'package:frigoligo/domain/repositories.dart';
import 'package:frigoligo/ui/article/controllers/article_content_controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockArticleRepository extends Mock implements ArticleRepository {}

void main() {
  group('ArticleContentController', () {
    late MockArticleRepository mockRepository;
    late ArticleContentController controller;

    setUp(() {
      mockRepository = MockArticleRepository();
      controller = ArticleContentController(
        articleRepository: mockRepository,
        articleId: 1,
      );
    });

    test('should set reading progress on repository', () async {
      when(
        () => mockRepository.setReadingProgress(any(), any()),
      ).thenAnswer((_) async {});

      await controller.setReadingProgress(0.75);

      verify(() => mockRepository.setReadingProgress(1, 0.75)).called(1);
    });
  });
}
