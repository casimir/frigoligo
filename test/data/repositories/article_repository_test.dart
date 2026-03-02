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

      await localStorageService.articles.update(article);
      await articleRepository.setReadingProgress(1, 0.5);

      final stream = articleRepository.watchReadingProgress(1);
      expect(await stream.elementAt(0), equals(0.5));

      final updatedArticle = article.copyWith(readingTime: 10);
      await localStorageService.articles.update(updatedArticle);

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

        await localStorageService.articles.update(article);
        await articleRepository.setReadingProgress(1, 0.5);

        final stream = articleRepository.watchReadingProgress(1);
        expect(await stream.elementAt(0), equals(0.5));

        // Update with same readingTime but different title
        final updatedArticle = article.copyWith(title: 'Updated Title');
        await localStorageService.articles.update(updatedArticle);

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

    group('read progress sync', () {
      final article = Article(
        id: 1,
        createdAt: DateTime(2000),
        updatedAt: DateTime(2000),
        title: 'Title',
        url: 'https://somewhere.org/articles/1',
        readingTime: 5,
        tags: [],
      );

      test(
        'getDirtyProgress returns only records updated after since',
        () async {
          await localStorageService.articles.update(article);
          await articleRepository.setReadingProgress(1, 0.4);

          final before = DateTime.now().subtract(const Duration(minutes: 1));
          final after = DateTime.now().add(const Duration(minutes: 1));

          final results = await articleRepository.getDirtyProgress(before);
          expect(results, hasLength(1));
          expect(results.first.articleId, equals(1));
          expect(results.first.progress, equals(0.4));

          final resultsAfter = await articleRepository.getDirtyProgress(after);
          expect(resultsAfter, isEmpty);
        },
      );

      test('applyProgress applies update when remote is newer', () async {
        await localStorageService.articles.update(article);
        await articleRepository.setReadingProgress(1, 0.3);

        final newerThanNow = DateTime.now().add(const Duration(days: 1));
        await articleRepository.applyProgress([
          (articleId: 1, progress: 0.9, updatedAt: newerThanNow),
        ]);

        final progress = await articleRepository.watchReadingProgress(1).first;
        expect(progress, equals(0.9));
      });

      test('applyProgress skips update when remote is older', () async {
        await localStorageService.articles.update(article);
        await articleRepository.setReadingProgress(1, 0.8);

        final olderThanNow = DateTime.now().subtract(const Duration(days: 1));
        await articleRepository.applyProgress([
          (articleId: 1, progress: 0.1, updatedAt: olderThanNow),
        ]);

        final progress = await articleRepository.watchReadingProgress(1).first;
        expect(progress, equals(0.8));
      });

      test('applyProgress skips unknown articles', () async {
        await articleRepository.applyProgress([
          (articleId: 999, progress: 0.5, updatedAt: DateTime.now()),
        ]);
        final progress = await articleRepository
            .watchReadingProgress(999)
            .first;
        expect(progress, isNull);
      });
    });
  });
}
