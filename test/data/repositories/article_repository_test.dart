import 'package:drift/drift.dart' show Value;
import 'package:frigoligo/data/repositories/article_repository.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/database/models/article.drift.dart';
import 'package:frigoligo/data/services/local/storage/storage_service.dart';
import 'package:frigoligo/domain/repositories.dart';
import 'package:test/test.dart';

void main() {
  group('ArticleRepositoryImpl', () {
    late DB db;
    late LocalStorageService localStorageService;
    late ArticleRepository articleRepository;

    setUp(() {
      db = DB(inMemory());
      localStorageService = LocalStorageService(db: db);
      articleRepository = ArticleRepositoryImpl(
        localStorageService: localStorageService,
      );
    });

    tearDown(() async {
      await db.close();
    });

    test('should stream article data', () async {
      final article1 = Article(
        id: 1,
        createdAt: DateTime(2000),
        updatedAt: DateTime(2000),
        title: 'Title',
        url: 'https://somewhere.org/articles/1',
        readingTime: 1,
        tags: [],
      );
      final article2 = article1.copyWith(readingTime: 10);

      final stream = articleRepository.watchData(1);
      expect(await stream.elementAt(0), equals(null));

      await localStorageService.articles.update(article1);
      final data1 = await stream.elementAt(0);
      expect(data1, isNotNull);
      expect(data1!.id, equals(article1.id));
      expect(data1.readingTime, equals(article1.readingTime));

      await localStorageService.articles.update(article2);
      final data2 = await stream.elementAt(0);
      expect(data2, isNotNull);
      expect(data2!.id, equals(article2.id));
      expect(data2.readingTime, equals(article2.readingTime));

      await localStorageService.articles.delete(1);
      expect(await stream.elementAt(0), equals(null));
    });

    test('should stream article content', () async {
      final article = Article(
        id: 1,
        createdAt: DateTime(2000),
        updatedAt: DateTime(2000),
        title: 'Title',
        url: 'https://somewhere.org/articles/1',
        content: 'Content',
        readingTime: 1,
        tags: [],
      );

      final stream = articleRepository.watchContent(1);
      expect(await stream.elementAt(0), equals(null));

      await localStorageService.articles.update(article);
      expect(await stream.elementAt(0), equals('Content'));

      await localStorageService.articles.update(
        article.copyWith(content: const Value(null)),
      );
      expect(await stream.elementAt(0), equals(null));

      await localStorageService.articles.update(
        article.copyWith(content: const Value('Content2')),
      );
      expect(await stream.elementAt(0), equals('Content2'));

      await localStorageService.articles.delete(1);
      expect(await stream.elementAt(0), equals(null));
    });

    test('should get and set reading progress', () async {
      final article = Article(
        id: 1,
        createdAt: DateTime(2000),
        updatedAt: DateTime(2000),
        title: 'Title',
        url: 'https://somewhere.org/articles/1',
        content: 'Content',
        readingTime: 1,
        tags: [],
      );

      final stream = articleRepository.watchReadingProgress(1);
      expect(await stream.elementAt(0), equals(null));

      await localStorageService.articles.update(article);
      expect(await stream.elementAt(0), equals(null));

      await articleRepository.setReadingProgress(1, 0.5);
      expect(await stream.elementAt(0), equals(0.5));

      await localStorageService.articles.delete(1);
      expect(await stream.elementAt(0), equals(null));
    });

    test('should evict scroll position when readingTime changes', () async {
      final article = Article(
        id: 1,
        createdAt: DateTime(2000),
        updatedAt: DateTime(2000),
        title: 'Title',
        url: 'https://somewhere.org/articles/1',
        content: 'Content',
        readingTime: 5,
        tags: [],
      );

      // Insert article and set scroll position
      await localStorageService.articles.update(article);
      await articleRepository.setReadingProgress(1, 0.5);

      // Verify scroll position exists
      final stream = articleRepository.watchReadingProgress(1);
      expect(await stream.elementAt(0), equals(0.5));

      // Update article with different readingTime
      final updatedArticle = article.copyWith(readingTime: 10);
      await localStorageService.articles.update(updatedArticle);

      // Verify scroll position was evicted
      expect(await stream.elementAt(0), equals(null));
    });

    test(
      'should preserve scroll position when readingTime unchanged',
      () async {
        final article = Article(
          id: 1,
          createdAt: DateTime(2000),
          updatedAt: DateTime(2000),
          title: 'Title',
          url: 'https://somewhere.org/articles/1',
          content: 'Content',
          readingTime: 5,
          tags: [],
        );

        // Insert article and set scroll position
        await localStorageService.articles.update(article);
        await articleRepository.setReadingProgress(1, 0.5);

        // Verify scroll position exists
        final stream = articleRepository.watchReadingProgress(1);
        expect(await stream.elementAt(0), equals(0.5));

        // Update article with same readingTime but different title
        final updatedArticle = article.copyWith(title: 'Updated Title');
        await localStorageService.articles.update(updatedArticle);

        // Verify scroll position still exists
        expect(await stream.elementAt(0), equals(0.5));
      },
    );

    test('delete returns true when article exists', () async {
      final article = Article(
        id: 1,
        createdAt: DateTime(2000),
        updatedAt: DateTime(2000),
        title: 'Title',
        url: 'https://somewhere.org/articles/1',
        readingTime: 1,
        tags: [],
      );

      await localStorageService.articles.update(article);
      expect(await articleRepository.delete(1), isTrue);
    });

    test('delete returns false when article does not exist', () async {
      expect(await articleRepository.delete(999), isFalse);
    });
  });
}
