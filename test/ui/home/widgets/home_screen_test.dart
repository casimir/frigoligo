import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/config/dependencies.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/database/models/article.drift.dart';
import 'package:frigoligo/data/services/local/storage/storage_service.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/home/controllers/home_screen_controller.dart';
import 'package:frigoligo/ui/home/widgets/home_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HomeScreen', () {
    late DB db;

    setUp(() async {
      db = DB(inMemory());
      setupDependencies(withDB: db);
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
          url: '',
          content: 'Test content $id',
          readingTime: 5,
          tags: [],
        ),
      );
    }

    testWidgets('should load with articles in database', (tester) async {
      // setup side by side layout
      tester.view.physicalSize = const Size(900, 600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      for (int i = 1; i <= 2; i++) {
        await insertArticle(id: i);
      }

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: HomeScreen(
              controller: HomeScreenController(
                queryRepository: dependencies.get(),
              ),
              contentBuilder: (context, title, content) =>
                  Center(child: Text(content)),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('Test content 1'), findsOneWidget);
    });

    testWidgets('should open article specified by initialArticleId', (
      tester,
    ) async {
      // setup side by side layout
      tester.view.physicalSize = const Size(900, 600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      for (int i = 1; i <= 3; i++) {
        await insertArticle(id: i);
      }

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: HomeScreen(
              controller: HomeScreenController(
                queryRepository: dependencies.get(),
              ),
              initialArticleId: 2,
              contentBuilder: (context, title, content) =>
                  Center(child: Text(content)),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      // Article 2 should be selected, not article 1
      expect(find.text('Test content 2'), findsOneWidget);
      expect(find.text('Test content 1'), findsNothing);
    });

    testWidgets(
      'should fallback to first article when initialArticleId not found',
      (tester) async {
        // setup side by side layout
        tester.view.physicalSize = const Size(900, 600);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        for (int i = 1; i <= 2; i++) {
          await insertArticle(id: i);
        }

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: HomeScreen(
                controller: HomeScreenController(
                  queryRepository: dependencies.get(),
                ),
                initialArticleId: 999, // non-existent
                contentBuilder: (context, title, content) =>
                    Center(child: Text(content)),
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(HomeScreen), findsOneWidget);
        // Should fallback to first article
        expect(find.text('Test content 1'), findsOneWidget);
      },
    );
  });
}
