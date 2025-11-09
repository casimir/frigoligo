import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/config/dependencies.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/database/models/article.drift.dart';
import 'package:frigoligo/data/services/local/storage/storage_service.dart';
import 'package:frigoligo/providers/settings.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/home/controllers/home_screen_controller.dart';
import 'package:frigoligo/ui/home/widgets/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              contentBuilder:
                  (context, title, content) => Center(child: Text(content)),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('Test content 1'), findsOneWidget);
    });

    testWidgets('should save article ID on selected index change', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({});
      await Settings.init();

      for (int i = 0; i < 2; i++) {
        await insertArticle(id: i + 10);
      }

      final container = ProviderContainer();

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: HomeScreen(
              controller: HomeScreenController(
                queryRepository: dependencies.get(),
              ),
              contentBuilder: (context, title, content) => const Placeholder(),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(
        find
            .ancestor(
              of: find.byKey(const ValueKey('article-navigation-11')),
              matching: find.byType(InkWell),
            )
            .first,
      );
      await tester.pumpAndSettle();

      final settings = container.read(settingsProvider);
      final savedArticleId = settings[Sk.selectedArticleId];
      expect(savedArticleId, 11);
    });
  });
}
