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

    testWidgets('should load with 3 articles in database', (tester) async {
      // setup side by side layout
      tester.view.physicalSize = const Size(900, 600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      final localStorageService = dependencies.get<LocalStorageService>();
      for (int i = 1; i <= 3; i++) {
        await localStorageService.articles.update(
          Article(
            id: i,
            createdAt: DateTime(2000 + i),
            updatedAt: DateTime(2000 + i),
            title: 'Test Article $i',
            url: 'https://example.com/article$i',
            content: 'Test content $i',
            readingTime: 5,
            tags: [],
          ),
        );
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
  });
}
