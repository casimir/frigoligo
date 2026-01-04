import 'package:cadanse/components/widgets/adaptive/actions_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/config/dependencies.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/domain/models/article_data.dart';
import 'package:frigoligo/domain/sync/sync_manager.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/article/controllers/article_screen_controller.dart';
import 'package:frigoligo/ui/article/states.dart';
import 'package:frigoligo/ui/article/widgets/article_content.dart';
import 'package:frigoligo/ui/article/widgets/article_content_placeholder.dart';
import 'package:frigoligo/ui/article/widgets/article_screen.dart';
import 'package:frigoligo/ui/core/states.dart';
import 'package:frigoligo/ui/core/widgets/remote_sync.dart';
import 'package:frigoligo/ui/core/widgets/src/navigation_split_view/navigation_split_view.dart';
import 'package:mocktail/mocktail.dart';

class MockArticleScreenController extends Mock
    implements ArticleScreenController {}

class _FakeSyncManagerState extends SyncManagerState {
  _FakeSyncManagerState(this._state);

  final SyncState _state;

  @override
  SyncState build() => _state;
}

class _FakeArticleState extends ArticleState {
  _FakeArticleState(this._data);

  final ArticleData _data;

  @override
  Future<ArticleData?> build(int articleId) async {
    return _data;
  }
}

class _FakeArticleContentState extends ArticleContentState {
  _FakeArticleContentState(this._content);

  final String _content;

  @override
  Future<String?> build(int articleId) async {
    return _content;
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue(Rect.zero);
    registerFallbackValue(Uri());
  });

  group('ArticleScreen', () {
    late DB db;
    late MockArticleScreenController mockController;

    setUp(() {
      db = DB(inMemory());
      setupDependencies(withDB: db);
      SyncManager.init(
        localStorageService: dependencies.get(),
        serverSessionRepository: dependencies.get(),
        configStoreService: dependencies.get(),
        appBadgeService: dependencies.get(),
      );

      mockController = MockArticleScreenController();
      when(() => mockController.articleId).thenReturn(1);
    });

    tearDown(() async {
      await dependencies.reset();
      await db.close();
    });

    group('', () {
      Widget buildWidget(bool expanded) {
        return ProviderScope(
          overrides: [
            // ignore: scoped_providers_should_specify_dependencies
            syncManagerStateProvider.overrideWith(
              () => _FakeSyncManagerState(
                const SyncState(
                  isWorking: true,
                  progressValue: 0.5,
                  lastError: null,
                  pendingCount: 0,
                ),
              ),
            ),
          ],
          child: MaterialApp(
            home: Material(
              child: NavigationSplitViewScope(
                isContentExpanded: expanded,
                layout: NavigationSplitViewLayout.sideBySide,
                child: ArticleScreen(controller: mockController),
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        );
      }

      testWidgets(
        'should show the progress indicator when it is not already shown',
        (tester) async {
          await tester.pumpWidget(buildWidget(true));
          await tester.pumpAndSettle();

          expect(find.byType(RemoteSyncProgressIndicator), findsOneWidget);
        },
      );

      testWidgets('should not show the progress indicator when already shown', (
        tester,
      ) async {
        await tester.pumpWidget(buildWidget(false));
        await tester.pumpAndSettle();

        expect(find.byType(RemoteSyncProgressIndicator), findsNothing);
      });
    });

    group('', () {
      Widget buildWidget(bool hasContent) {
        final state = ArticleData(
          id: 1,
          title: 'Article Title',
          domainName: 'domain.tld',
          url: 'https://domain.tld/article',
          hasContent: hasContent,
          readingTime: 5,
          previewPicture: null,
          tags: ['tag1', 'tag2'],
          isArchived: false,
          isStarred: false,
        );
        return ProviderScope(
          overrides: [
            // ignore: scoped_providers_should_specify_dependencies
            articleStateProvider(
              1,
            ).overrideWith(() => _FakeArticleState(state)),
            // ignore: scoped_providers_should_specify_dependencies
            if (hasContent)
              articleContentStateProvider(1).overrideWith(
                () => _FakeArticleContentState('Some article content'),
              ),
          ],
          child: MaterialApp(
            home: Material(
              child: ArticleScreen(
                controller: mockController,
                contentBuilder: (context, title, content) =>
                    const Placeholder(),
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        );
      }

      testWidgets('should display the article content and actions', (
        tester,
      ) async {
        await tester.pumpWidget(buildWidget(true));
        await tester.pumpAndSettle();

        expect(find.byType(ArticleContent), findsOneWidget);
        expect(find.byType(ArticleContentPlaceholder), findsNothing);

        // - check archive action last because it pops the navigation stack
        // - skip delete and details and reading settings because of navigation
        //   complexity

        when(
          () => mockController.setStarred(any()),
        ).thenAnswer((_) async => {});
        await tester.tap(find.byKey(kArticleActionStar));
        await tester.pumpAndSettle();
        verify(() => mockController.setStarred(true)).called(1);

        await tester.tap(find.byType(ActionsMenuButton));
        await tester.pumpAndSettle();
        when(
          () => mockController.openInBrowser(any()),
        ).thenAnswer((_) async => {});
        await tester.tap(find.byKey(kArticleActionOpenInBrowser));
        await tester.pumpAndSettle();
        verify(
          () => mockController.openInBrowser(
            Uri.parse('https://domain.tld/article'),
          ),
        ).called(1);

        await tester.tap(find.byType(ActionsMenuButton));
        await tester.pumpAndSettle();
        when(
          () => mockController.shareArticle(any(), any(), any()),
        ).thenAnswer((_) async => {});
        await tester.tap(find.byKey(kArticleActionShare));
        await tester.pumpAndSettle();
        verify(
          () => mockController.shareArticle(
            'Article Title',
            'https://domain.tld/article',
            any(),
          ),
        ).called(1);

        when(
          () => mockController.setArchived(any()),
        ).thenAnswer((_) async => {});
        await tester.tap(find.byKey(kArticleActionArchive));
        verify(() => mockController.setArchived(true)).called(1);
      });

      testWidgets('should be able to handle an article without content', (
        tester,
      ) async {
        await tester.pumpWidget(buildWidget(false));
        await tester.pumpAndSettle();

        expect(find.byType(ArticleContentPlaceholder), findsOneWidget);
        expect(find.byType(ArticleContent), findsNothing);
        expect(find.byType(ActionsMenuButton), findsOneWidget);
      });
    });
  });
}
