import 'dart:ui';

import 'package:frigoligo/config/dependencies.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/database/models/article.drift.dart';
import 'package:frigoligo/data/services/local/storage/storage_service.dart';
import 'package:frigoligo/data/services/platform/sharing_service.dart';
import 'package:frigoligo/data/services/platform/urllauncher_service.dart';
import 'package:frigoligo/domain/managers/sync_manager.dart';
import 'package:frigoligo/services/remote_sync_actions.dart';
import 'package:frigoligo/ui/article/controllers/article_screen_controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockSyncManager extends Mock implements SyncManager {}

class MockSharingService extends Mock implements SharingService {}

class MockUrlLauncherService extends Mock implements UrlLauncherService {}

class MockEditArticleAction extends Mock implements EditArticleAction {}

void main() {
  group('ArticleScreenController', () {
    setUpAll(() {
      registerFallbackValue(MockEditArticleAction());
      registerFallbackValue(Rect.zero);
      registerFallbackValue(Uri());
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

    test(
      'should be able to set the archived and starred of the article',
      () async {
        final LocalStorageService localStorageService = dependencies.get();
        final mockSyncManager = MockSyncManager();
        final controller = ArticleScreenController(
          syncManager: mockSyncManager,
          sharingService: dependencies.get(),
          urlLauncherService: dependencies.get(),
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

        when(
          () => mockSyncManager.addAction(any()),
        ).thenAnswer((_) async => {});
        when(
          () => mockSyncManager.synchronize(withFinalRefresh: false),
        ).thenAnswer((_) async => {});

        await controller.setArchived(true);
        verify(
          () => mockSyncManager.addAction(
            const EditArticleAction(1, archived: true),
          ),
        ).called(1);

        await controller.setStarred(true);
        verify(
          () => mockSyncManager.addAction(
            const EditArticleAction(1, starred: true),
          ),
        ).called(1);

        verify(
          () => mockSyncManager.synchronize(withFinalRefresh: false),
        ).called(2);
      },
    );

    test('should be able to delete the article', () async {
      final mockSyncManager = MockSyncManager();
      when(() => mockSyncManager.addAction(any())).thenAnswer((_) async => {});
      when(
        () => mockSyncManager.synchronize(withFinalRefresh: false),
      ).thenAnswer((_) async => {});

      final controller = ArticleScreenController(
        syncManager: mockSyncManager,
        sharingService: MockSharingService(),
        urlLauncherService: MockUrlLauncherService(),
        articleId: 1,
      );
      await controller.deleteArticle();

      verify(
        () => mockSyncManager.addAction(const DeleteArticleAction(1)),
      ).called(1);
      verify(
        () => mockSyncManager.synchronize(withFinalRefresh: false),
      ).called(1);
    });

    test('should be able to share the article', () async {
      final sharingService = MockSharingService();
      when(
        () => sharingService.shareAsText(
          captureAny(),
          captureAny(),
          sharePositionOrigin: any(named: 'sharePositionOrigin'),
        ),
      ).thenAnswer((_) async => {});

      final controller = ArticleScreenController(
        syncManager: MockSyncManager(),
        sharingService: sharingService,
        urlLauncherService: MockUrlLauncherService(),
        articleId: 1,
      );
      await controller.shareArticle('title', 'url', Rect.zero);

      verify(
        () => sharingService.shareAsText(
          'title',
          'url',
          sharePositionOrigin: any(named: 'sharePositionOrigin'),
        ),
      ).called(1);
    });

    test('should be able to open the article in the browser', () async {
      final urlLauncherService = MockUrlLauncherService();
      when(
        () => urlLauncherService.launch(any()),
      ).thenAnswer((_) async => true);

      final controller = ArticleScreenController(
        syncManager: MockSyncManager(),
        sharingService: MockSharingService(),
        urlLauncherService: urlLauncherService,
        articleId: 1,
      );
      await controller.openInBrowser(Uri.parse('https://example.com'));

      verify(
        () => urlLauncherService.launch(Uri.parse('https://example.com')),
      ).called(1);
    });
  });
}
