import 'package:frigoligo/data/repositories/tag_repository.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/database/models/article.drift.dart';
import 'package:frigoligo/data/services/local/storage/storage_service.dart';
import 'package:frigoligo/domain/repositories.dart';
import 'package:test/test.dart';

void main() {
  group('TagRepositoryImpl', () {
    late DB db;
    late LocalStorageService localStorageService;
    late TagRepository tagRepository;

    setUp(() {
      db = DB(inMemory());
      localStorageService = LocalStorageService(db: db);
      tagRepository = TagRepositoryImpl(
        localStorageService: localStorageService,
      );
    });

    tearDown(() async {
      await db.close();
    });

    test(
      'should return all tags with proper deduplication and sorting',
      () async {
        await localStorageService.articles.update(
          Article(
            id: 1,
            createdAt: DateTime(2000),
            updatedAt: DateTime(2000),
            title: 'Title 1',
            url: 'https://example.com/article/1',
            readingTime: 1,
            tags: ['technology'],
          ),
        );
        await localStorageService.articles.update(
          Article(
            id: 2,
            createdAt: DateTime(2000),
            updatedAt: DateTime(2000),
            title: 'Title 2',
            url: 'https://example.com/article/2',
            readingTime: 5,
            tags: ['zebra', 'apple', 'banana', 'cherry'],
          ),
        );
        await localStorageService.articles.update(
          Article(
            id: 3,
            createdAt: DateTime(2000),
            updatedAt: DateTime(2000),
            title: 'Title 3',
            url: 'https://example.com/article/2',
            readingTime: 3,
            tags: ['technology', 'science'],
          ),
        );

        final tags = await tagRepository.getAll();
        expect(
          tags,
          equals([
            'apple',
            'banana',
            'cherry',
            'science',
            'technology',
            'zebra',
          ]),
        );
      },
    );
  });
}
