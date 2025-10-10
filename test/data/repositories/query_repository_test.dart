import 'package:drift/drift.dart' as drift;
import 'package:frigoligo/data/repositories/query_repository.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/database/models/article.drift.dart';
import 'package:frigoligo/data/services/local/storage/storage_service.dart';
import 'package:frigoligo/domain/repositories.dart';
import 'package:test/test.dart';

void main() {
  group('QueryRepositoryImpl', () {
    late DB db;
    late LocalStorageService localStorageService;
    late QueryRepository queryRepository;

    setUp(() {
      db = DB(inMemory());
      localStorageService = LocalStorageService(db: db);
      queryRepository = QueryRepositoryImpl(
        localStorageService: localStorageService,
      );
    });

    tearDown(() async {
      queryRepository.dispose();
      await db.close();
    });

    test('should stream query updates', () async {
      final initial = queryRepository.query;
      final newQuery1 = initial.copyWith(tags: ['test']);
      final newQuery2 = initial.copyWith(domains: ['test.com']);

      final subscription = queryRepository.queryStream.listen((_) {});

      expectLater(queryRepository.queryStream, emits(newQuery1));

      queryRepository.query = newQuery1;
      // I could not find a way to test "don't broadcast on same value".
      // Let's just trigger the code path for a sanity check.
      queryRepository.query = newQuery1;

      expect(queryRepository.query, equals(newQuery1));

      subscription.cancel();
      queryRepository.query = newQuery2;

      expect(queryRepository.query, equals(newQuery2));
    });

    test(
      'should allow to get the articles corresponding the current query',
      () async {
        Article buildArticle(int id, {bool archived = false}) {
          final baseDate = DateTime(2000);
          return Article(
            id: id,
            createdAt: baseDate.add(Duration(minutes: id)),
            updatedAt: baseDate.add(Duration(hours: id)),
            title: 'Title $id',
            url: 'https://somewhere.org/articles/$id',
            readingTime: id,
            tags: [],
            archivedAt: archived ? baseDate.add(Duration(days: id)) : null,
          );
        }

        Future<void> expectIds(Set<int> ids) async {
          final articleIds = await queryRepository.watchArticleIds().first;
          expect(articleIds.toSet(), equals(ids));
        }

        final archivedArticle = buildArticle(2, archived: true);

        await localStorageService.articles.update(buildArticle(1));
        await localStorageService.articles.update(archivedArticle);

        // The default query filters unread
        expect(await queryRepository.getResultCount(), equals(1));
        await expectIds({1});

        queryRepository.query = const Query();

        expect(await queryRepository.getResultCount(), equals(2));
        await expectIds({1, 2});

        await localStorageService.articles.update(buildArticle(3));

        expect(await queryRepository.getResultCount(), equals(3));
        await expectIds({1, 2, 3});

        queryRepository.query = const Query(state: StateFilter.archived);

        expect(await queryRepository.getResultCount(), equals(1));
        await expectIds({2});

        await localStorageService.articles.update(
          archivedArticle.copyWith(archivedAt: const drift.Value(null)),
        );

        expect(await queryRepository.getResultCount(), equals(0));
        await expectIds({});
      },
    );

    test('should combine query attributes correctly', () async {
      await localStorageService.articles.update(
        Article(
          id: 1,
          createdAt: DateTime(2000),
          updatedAt: DateTime(2000),
          title: 'Title of the article',
          domainName: 'somewhere.org',
          url: 'https://somewhere.org/articles/1',
          readingTime: 12,
          tags: ['test'],
        ),
      );
      queryRepository.query = const Query(
        text: 'title',
        textMode: SearchTextMode.title,
        state: StateFilter.all,
        onlyStarred: false,
        tags: ['test'],
        domains: ['somewhere.org'],
      );

      expect(await queryRepository.watchArticleIds().first, equals([1]));
    });

    test('should allow to search in article content', () async {
      await localStorageService.articles.update(
        Article(
          id: 1,
          createdAt: DateTime(2000),
          updatedAt: DateTime(2000),
          title: 'Title of the article',
          url: 'https://somewhere.org/articles/1',
          content: 'Content of the article',
          readingTime: 12,
          tags: [],
        ),
      );

      queryRepository.query = const Query(
        text: 'content',
        textMode: SearchTextMode.content,
      );

      expect(await queryRepository.watchArticleIds().first, equals([1]));
    });

    test('should allow to list the available domains', () async {
      Future<void> persistNewArticle(
        int id,
        String domainName, {
        bool archived = false,
      }) {
        final baseDate = DateTime(2000);
        final article = Article(
          id: id,
          createdAt: baseDate.add(Duration(minutes: id)),
          updatedAt: baseDate.add(Duration(hours: id)),
          title: 'Title $id',
          domainName: domainName,
          url: 'https://somewhere.org/articles/$id',
          readingTime: id,
          archivedAt: archived ? baseDate.add(Duration(days: id)) : null,
          tags: [],
        );

        return localStorageService.articles.update(article);
      }

      await persistNewArticle(1, 'web1.com');
      await persistNewArticle(2, 'web2.com', archived: true);
      await persistNewArticle(3, 'web3.com');

      // The default query filters unread
      expect(await queryRepository.getResultCount(), equals(2));

      final domains = await queryRepository.listAvailableDomains();
      expect(domains, ['web1.com', 'web3.com']);
    });

    test('should allow to list the available tags', () async {
      Future<void> persistNewArticle(
        int id,
        List<String> tags, {
        bool archived = false,
      }) {
        final baseDate = DateTime(2000);
        final article = Article(
          id: id,
          createdAt: baseDate.add(Duration(minutes: id)),
          updatedAt: baseDate.add(Duration(hours: id)),
          title: 'Title $id',
          url: 'https://somewhere.org/articles/$id',
          readingTime: id,
          tags: tags,
          archivedAt: archived ? baseDate.add(Duration(days: id)) : null,
        );

        return localStorageService.articles.update(article);
      }

      await persistNewArticle(1, ['tag10', 'tag11']);
      await persistNewArticle(2, ['tag2'], archived: true);
      await persistNewArticle(3, ['tag3']);
      await persistNewArticle(4, []);

      // The default query filters unread
      expect(await queryRepository.getResultCount(), equals(3));

      final tags = await queryRepository.listAvailableTags();
      expect(tags, ['tag10', 'tag11', 'tag3']);
    });
  });
}
