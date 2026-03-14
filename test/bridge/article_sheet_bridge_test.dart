import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/bridge/article_sheet_bridge.dart';
import 'package:frigoligo/domain/models/article_data.dart';
import 'package:frigoligo/domain/repositories.dart';
import 'package:frigoligo/domain/sync/sync_manager.dart';
import 'package:frigoligo/pigeon/article_sheet.g.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

class MockArticleRepository extends Mock implements ArticleRepository {}

class MockTagRepository extends Mock implements TagRepository {}

class MockSyncManager extends Mock implements SyncManager {}

class MockArticleSheetApi extends Mock implements ArticleSheetApi {}

class MockAppLocalizations extends Mock implements AppLocalizations {}

class FakeArticleSheetData extends Fake implements ArticleSheetData {}

const _testArticle = ArticleData(
  id: 1,
  title: 'Test Article',
  domainName: 'example.com',
  url: 'https://example.com/article',
  hasContent: true,
  readingTime: 5,
  previewPicture: null,
  tags: ['tag1'],
  isArchived: false,
  isStarred: false,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ArticleSheetBridge', () {
    late MockArticleRepository articleRepository;
    late MockTagRepository tagRepository;
    late MockSyncManager syncManager;
    late MockArticleSheetApi api;
    late MockAppLocalizations l10n;
    late ArticleSheetBridge bridge;

    setUpAll(() {
      registerFallbackValue(const EditArticleAction(0, tags: []));
      registerFallbackValue(FakeArticleSheetData());
    });

    setUp(() {
      articleRepository = MockArticleRepository();
      tagRepository = MockTagRepository();
      syncManager = MockSyncManager();
      api = MockArticleSheetApi();
      l10n = MockAppLocalizations();

      when(() => l10n.article_addTags).thenReturn('Add tags');
      when(() => l10n.article_openInBrowser).thenReturn('Open in browser');
      when(() => l10n.articlefields_readingTime).thenReturn('Reading time');
      when(() => l10n.article_refetchContent).thenReturn('Refetch');
      when(() => l10n.g_share).thenReturn('Share');
      when(() => l10n.g_article).thenReturn('Article');
      when(() => l10n.articlefields_tags).thenReturn('Tags');
      when(() => l10n.articlefields_title).thenReturn('Title');
      when(() => l10n.articlefields_website).thenReturn('Website');
      when(() => l10n.article_readingTime(any())).thenReturn('5 min');

      when(() => api.open()).thenAnswer((_) async {});
      when(() => api.update(any())).thenAnswer((_) async {});
      when(() => api.close()).thenAnswer((_) async {});

      bridge = ArticleSheetBridge(
        articleRepository: articleRepository,
        tagRepository: tagRepository,
        syncManager: syncManager,
        api: api,
      );
    });

    test('open: pushes article data on stream event', () async {
      final controller = StreamController<ArticleData?>();
      when(
        () => articleRepository.watchData(1),
      ).thenAnswer((_) => controller.stream);

      await bridge.open(1, l10n: l10n);
      controller.add(_testArticle);
      await Future.microtask(() {});

      final captured = verify(() => api.update(captureAny())).captured;
      expect(captured, hasLength(1));
      final data = captured.first as ArticleSheetData;
      expect(data.title, _testArticle.title);
      expect(data.domain, 'example.com');
      expect(data.tags, _testArticle.tags);
      await controller.close();
    });

    test('setTags: enqueues EditArticleAction and synchronizes', () async {
      final controller = StreamController<ArticleData?>();
      when(
        () => articleRepository.watchData(1),
      ).thenAnswer((_) => controller.stream);
      when(() => syncManager.addAction(any())).thenAnswer((_) async {});
      when(
        () => syncManager.synchronize(withFinalRefresh: false),
      ).thenAnswer((_) async => {});

      await bridge.open(1, l10n: l10n);
      await bridge.setTags(['tag1', 'tag2']);

      verify(
        () => syncManager.addAction(
          const EditArticleAction(1, tags: ['tag1', 'tag2']),
        ),
      ).called(1);
      verify(() => syncManager.synchronize(withFinalRefresh: false)).called(1);
      await controller.close();
    });

    test(
      'refetchContent: enqueues RefetchArticleAction and synchronizes',
      () async {
        final controller = StreamController<ArticleData?>();
        when(
          () => articleRepository.watchData(1),
        ).thenAnswer((_) => controller.stream);
        when(() => syncManager.addAction(any())).thenAnswer((_) async {});
        when(
          () => syncManager.synchronize(withFinalRefresh: false),
        ).thenAnswer((_) async => {});

        await bridge.open(1, l10n: l10n);
        await bridge.refetchContent();

        verify(
          () => syncManager.addAction(const RefetchArticleAction(1)),
        ).called(1);
        verify(
          () => syncManager.synchronize(withFinalRefresh: false),
        ).called(1);
        await controller.close();
      },
    );

    test('getAllTags and dismiss: delegates and closes native sheet', () async {
      final controller = StreamController<ArticleData?>();
      when(
        () => articleRepository.watchData(1),
      ).thenAnswer((_) => controller.stream);
      when(() => tagRepository.getAll()).thenAnswer((_) async => ['a', 'b']);

      await bridge.open(1, l10n: l10n);
      expect(await bridge.getAllTags(), ['a', 'b']);
      await bridge.dismiss();

      verify(() => api.close()).called(1);
      await controller.close();
    });
  });
}
