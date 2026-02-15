import 'package:cadanse/components/widgets/adaptive/actions_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/config/dependencies.dart';
import 'package:frigoligo/data/services/local/storage/config_store_backends/in_memory_backend.dart';
import 'package:frigoligo/data/services/local/storage/config_store_service.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/database/models/article.drift.dart';
import 'package:frigoligo/data/services/local/storage/storage_service.dart';
import 'package:frigoligo/domain/sync/sync_manager.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/article/widgets/article_screen.dart';
import 'package:frigoligo/ui/home/controllers/home_screen_controller.dart';
import 'package:frigoligo/ui/home/widgets/home_screen.dart';

void main() {
  group('post action navigation', () {
    late DB db;

    setUp(() async {
      db = DB(inMemory());
      setupDependencies(withConfigStoreBackend: InMemoryBackend(), withDB: db);
      await dependencies.get<ConfigStoreService>().initialize();
      SyncManager.init(
        appBadgeService: dependencies.get(),
        configStoreService: dependencies.get(),
        localStorageService: dependencies.get(),
        articleRepository: dependencies.get(),
        remoteActionRepository: dependencies.get(),
        serverSessionRepository: dependencies.get(),
      );
    });

    tearDown(() async {
      await dependencies.reset();
      await db.close();
    });

    Future<void> insertArticle({required int id}) async {
      final localStorageService = dependencies.get<LocalStorageService>();
      await localStorageService.articles.update(
        Article(
          id: id,
          createdAt: DateTime(2000 + id),
          updatedAt: DateTime(2000 + id),
          title: 'Test Article $id',
          url: 'https://example.com/$id',
          content: 'Test content $id',
          readingTime: 5,
          tags: [],
        ),
      );
    }

    Widget buildApp() {
      return ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: HomeScreen(
            controller: HomeScreenController(
              queryRepository: dependencies.get(),
            ),
            contentBuilder: (context, title, content) =>
                Center(child: Text(content)),
          ),
        ),
      );
    }

    Future<void> seedArticles() async {
      await insertArticle(id: 1);
      await insertArticle(id: 2);
    }

    Future<void> openArticleInFullMode(WidgetTester tester) async {
      await tester.tap(find.text('Test Article 2'));
      await tester.pumpAndSettle();
    }

    Future<void> triggerDelete(WidgetTester tester) async {
      await tester.tap(find.byType(ActionsMenuButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(kArticleActionDelete));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
    }

    Future<void> triggerArchive(WidgetTester tester) async {
      await tester.tap(find.byKey(kArticleActionArchive));
      await tester.pumpAndSettle();
    }

    group('delete article', () {
      testWidgets('in full mode navigates back to listing', (tester) async {
        tester.view.physicalSize = const Size(700, 600);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await seedArticles();
        await tester.pumpWidget(buildApp());
        await tester.pumpAndSettle();

        expect(find.byType(ArticleScreen), findsNothing);

        await openArticleInFullMode(tester);
        expect(find.byType(ArticleScreen), findsOneWidget);

        await triggerDelete(tester);

        expect(find.byType(ArticleScreen), findsNothing);
      });

      testWidgets('in side-by-side mode stays on current view', (tester) async {
        tester.view.physicalSize = const Size(900, 600);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await seedArticles();
        await tester.pumpWidget(buildApp());
        await tester.pumpAndSettle();

        expect(find.byType(ArticleScreen), findsOneWidget);

        await triggerDelete(tester);

        expect(find.text('Test Article 1'), findsOneWidget);
      });
    });

    group('archive article', () {
      testWidgets('in full mode navigates back to listing', (tester) async {
        tester.view.physicalSize = const Size(700, 600);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await seedArticles();
        await tester.pumpWidget(buildApp());
        await tester.pumpAndSettle();

        await openArticleInFullMode(tester);
        expect(find.byType(ArticleScreen), findsOneWidget);

        await triggerArchive(tester);

        expect(find.byType(ArticleScreen), findsNothing);
      });
    });
  });
}
