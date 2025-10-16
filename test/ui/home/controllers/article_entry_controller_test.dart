import 'dart:async';

import 'package:frigoligo/config/dependencies.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/database/models/article.drift.dart';
import 'package:frigoligo/data/services/local/storage/storage_service.dart';
import 'package:frigoligo/services/remote_sync.dart';
import 'package:frigoligo/services/remote_sync_actions.dart';
import 'package:frigoligo/ui/home/controllers/article_entry_controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockRemoteSyncer extends Mock implements RemoteSyncer {}

class MockEditArticleAction extends Mock implements EditArticleAction {}

void main() {
  group('ArticleEntryController', () {
    setUpAll(() {
      registerFallbackValue(MockEditArticleAction());
    });

    late DB db;

    setUp(() {
      db = DB(inMemory());
      setupDependencies(withDB: db);
    });

    tearDown(() async {
      await dependencies.reset();
      await db.close();
    });

    test('should be able to change the tags query', () async {
      final LocalStorageService localStorageService = dependencies.get();
      final QueryRepository queryRepository = dependencies.get();
      final controller = ArticleEntryController(
        queryRepository: queryRepository,
        syncer: MockRemoteSyncer(),
        articleId: 1,
      );

      await localStorageService.articles.update(
        Article(
          id: 1,
          createdAt: DateTime(2000),
          updatedAt: DateTime(2000),
          title: 'Title',
          url: 'https://somewhere.org/articles/1',
          readingTime: 1,
          tags: [],
        ),
      );

      Completer completer = Completer();
      final subscription = queryRepository.queryStream.listen((_) {
        completer.complete();
      });

      controller.changeTagsSearchFilterTo('test');

      await completer.future;
      subscription.cancel();

      expect(queryRepository.query.tags, equals(['test']));
    });

    test(
      'should be able to set the archived and starred of the article',
      () async {
        final LocalStorageService localStorageService = dependencies.get();
        final mockRemoteSyncer = MockRemoteSyncer();
        final controller = ArticleEntryController(
          queryRepository: dependencies.get(),
          syncer: mockRemoteSyncer,
          articleId: 1,
        );

        await localStorageService.articles.update(
          Article(
            id: 1,
            createdAt: DateTime(2000),
            updatedAt: DateTime(2000),
            title: 'Title',
            url: 'https://somewhere.org/articles/1',
            readingTime: 1,
            tags: [],
          ),
        );

        when(() => mockRemoteSyncer.add(any())).thenAnswer((_) async => {});
        when(() => mockRemoteSyncer.synchronize()).thenAnswer((_) async => {});

        await controller.setArchived(true);
        verify(
          () =>
              mockRemoteSyncer.add(const EditArticleAction(1, archived: true)),
        ).called(1);

        await controller.setStarred(true);
        verify(
          () => mockRemoteSyncer.add(const EditArticleAction(1, starred: true)),
        ).called(1);

        verify(() => mockRemoteSyncer.synchronize()).called(2);
      },
    );
  });
}
