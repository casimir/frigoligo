import 'dart:ui';

import 'package:frigoligo/config/dependencies.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/platform/sharing_service.dart';
import 'package:frigoligo/data/services/platform/urllauncher_service.dart';
import 'package:frigoligo/domain/sync/sync_manager.dart';
import 'package:frigoligo/ui/article/controllers/article_sheet_controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockSyncManager extends Mock implements SyncManager {}

class MockSharingService extends Mock implements SharingService {}

class MockUrlLauncherService extends Mock implements UrlLauncherService {}

class MockTagRepository extends Mock implements TagRepository {}

class MockEditArticleAction extends Mock implements EditArticleAction {}

class MockRefetchArticleAction extends Mock implements RefetchArticleAction {}

class MockUri extends Mock implements Uri {}

void main() {
  group('ArticleSheetController', () {
    setUpAll(() {
      registerFallbackValue(MockEditArticleAction());
      registerFallbackValue(MockRefetchArticleAction());
      registerFallbackValue(MockUri());
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

    test('allTags', () async {
      final tagRepository = MockTagRepository();
      when(() => tagRepository.getAll()).thenAnswer((_) async => []);

      final controller = ArticleSheetController(
        syncManager: MockSyncManager(),
        tagRepository: tagRepository,
        sharingService: MockSharingService(),
        urlLauncherService: MockUrlLauncherService(),
        articleId: 1,
      );
      await controller.allTags();

      verify(() => tagRepository.getAll()).called(1);
    });

    test('refetchContent', () async {
      final syncManager = MockSyncManager();
      when(
        () => syncManager.addAction(captureAny()),
      ).thenAnswer((_) async => {});
      when(
        () => syncManager.synchronize(withFinalRefresh: false),
      ).thenAnswer((_) async => {});

      final controller = ArticleSheetController(
        syncManager: syncManager,
        tagRepository: MockTagRepository(),
        sharingService: MockSharingService(),
        urlLauncherService: MockUrlLauncherService(),
        articleId: 1,
      );
      await controller.refetchContent();

      verify(
        () => syncManager.addAction(const RefetchArticleAction(1)),
      ).called(1);
      verify(() => syncManager.synchronize(withFinalRefresh: false)).called(1);
    });

    test('setTags', () async {
      final syncManager = MockSyncManager();
      when(
        () => syncManager.addAction(captureAny()),
      ).thenAnswer((_) async => {});
      when(
        () => syncManager.synchronize(withFinalRefresh: false),
      ).thenAnswer((_) async => {});

      final controller = ArticleSheetController(
        syncManager: syncManager,
        tagRepository: MockTagRepository(),
        sharingService: MockSharingService(),
        urlLauncherService: MockUrlLauncherService(),
        articleId: 1,
      );
      await controller.setTags(['tag1', 'tag2']);

      verify(
        () => syncManager.addAction(
          const EditArticleAction(1, tags: ['tag1', 'tag2']),
        ),
      ).called(1);
      verify(() => syncManager.synchronize(withFinalRefresh: false)).called(1);
    });

    test('share', () async {
      final sharingService = MockSharingService();
      when(
        () => sharingService.shareAsText(
          captureAny(),
          captureAny(),
          sharePositionOrigin: any(named: 'sharePositionOrigin'),
        ),
      ).thenAnswer((_) async => {});

      final controller = ArticleSheetController(
        syncManager: MockSyncManager(),
        tagRepository: MockTagRepository(),
        sharingService: sharingService,
        urlLauncherService: MockUrlLauncherService(),
        articleId: 1,
      );
      await controller.share('title', 'url', Rect.zero);

      verify(
        () => sharingService.shareAsText(
          'title',
          'url',
          sharePositionOrigin: any(named: 'sharePositionOrigin'),
        ),
      ).called(1);
    });

    test('openInBrowser', () async {
      final urlLauncherService = MockUrlLauncherService();
      when(
        () => urlLauncherService.launch(any()),
      ).thenAnswer((_) async => true);

      final controller = ArticleSheetController(
        syncManager: MockSyncManager(),
        tagRepository: MockTagRepository(),
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
