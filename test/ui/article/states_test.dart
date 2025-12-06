import 'package:drift/drift.dart' as drift;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/config/dependencies.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/database/models/article.drift.dart';
import 'package:frigoligo/data/services/local/storage/storage_service.dart';
import 'package:frigoligo/ui/article/states.dart';
import 'package:frigoligo/ui/core/widgets/async_value_loader.dart';

void main() {
  group('articleContentState', () {
    late DB db;

    setUp(() {
      db = DB(inMemory());
      setupDependencies(withDB: db);
    });

    tearDown(() async {
      await dependencies.reset();
      await db.close();
    });

    testWidgets(
      'should provide the current state of the stored article content',
      (tester) async {
        final testArticle1 = Article(
          id: 1,
          createdAt: DateTime(2000),
          updatedAt: DateTime(2000),
          title: '',
          url: '',
          content: 'Content 1',
          readingTime: 1,
          tags: const [],
        );
        final testArticle1b = testArticle1.copyWith(
          content: const drift.Value('Content 2'),
        );

        final LocalStorageService localStorageService = dependencies.get();

        await tester.pumpWidget(
          ProviderScope(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Consumer(
                builder: (context, ref, child) {
                  return AsyncValueLoader(
                    value: ref.watch(
                      articleContentStateProvider(testArticle1.id),
                    ),
                    builder: (context, state) {
                      return Text('$state');
                    },
                  );
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('null'), findsOneWidget);

        await localStorageService.articles.update(testArticle1);
        await tester.pumpAndSettle();

        expect(find.text('Content 1'), findsOneWidget);

        await localStorageService.articles.update(testArticle1b);
        await tester.pumpAndSettle();

        expect(find.text('Content 2'), findsOneWidget);

        await localStorageService.articles.delete(testArticle1.id);
        await tester.pumpAndSettle();

        expect(find.text('null'), findsOneWidget);
      },
    );
  });
}
