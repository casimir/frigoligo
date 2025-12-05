import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/config/dependencies.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/database/models/article.drift.dart';
import 'package:frigoligo/data/services/local/storage/storage_service.dart';
import 'package:frigoligo/ui/core/states.dart';
import 'package:frigoligo/ui/core/widgets/async_value_loader.dart';
import 'package:frigoligo/ui/home/states.dart';

// Creating a mechanism to reliably and clearly wait for drift side-effects to
// settle is challenging. So, instead of hacking around with delays, the
// strategy is to use simple flutter widgets to orchestrate the tests.

void main() {
  group('articleStateProvider & articleExistsStateProvider', () {
    late DB db;

    setUp(() {
      db = DB(inMemory());
      setupDependencies(withDB: db);
    });

    tearDown(() async {
      await dependencies.reset();
      await db.close();
    });

    testWidgets('should provide the current state of the stored article', (
      tester,
    ) async {
      final testArticle1 = Article(
        id: 1,
        createdAt: DateTime(2000),
        updatedAt: DateTime(2000),
        title: '',
        url: '',
        readingTime: 1,
        tags: const [],
      );
      final testArticle1b = testArticle1.copyWith(readingTime: 2);

      final LocalStorageService localStorageService = dependencies.get();

      await tester.pumpWidget(
        ProviderScope(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    return AsyncValueLoader(
                      value: ref.watch(articleStateProvider(testArticle1.id)),
                      builder: (context, state) {
                        return Text('[Reading Time]: ${state?.readingTime}');
                      },
                    );
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return AsyncValueLoader(
                      value: ref.watch(
                        articleExistsStateProvider(testArticle1.id),
                      ),
                      builder: (context, state) {
                        return Text('[Exists]: $state');
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('[Reading Time]: null'), findsOneWidget);
      expect(find.text('[Exists]: false'), findsOneWidget);

      await localStorageService.articles.update(testArticle1);
      await tester.pumpAndSettle();

      expect(
        find.text('[Reading Time]: ${testArticle1.readingTime}'),
        findsOneWidget,
      );
      expect(find.text('[Exists]: true'), findsOneWidget);

      await localStorageService.articles.update(testArticle1b);
      await tester.pumpAndSettle();

      expect(
        find.text('[Reading Time]: ${testArticle1b.readingTime}'),
        findsOneWidget,
      );
      expect(find.text('[Exists]: true'), findsOneWidget);

      await localStorageService.articles.delete(testArticle1.id);
      await tester.pumpAndSettle();

      expect(find.text('[Reading Time]: null'), findsOneWidget);
      expect(find.text('[Exists]: false'), findsOneWidget);
    });
  });

  group('queryStateProvider', () {
    late DB db;

    setUp(() {
      db = DB(inMemory());
      setupDependencies(withDB: db);
    });

    tearDown(() async {
      await dependencies.reset();
      await db.close();
    });

    testWidgets('should provide the current state of the search query', (
      tester,
    ) async {
      final article1 = Article(
        id: 1,
        createdAt: DateTime(2000),
        updatedAt: DateTime(2000),
        title: '',
        domainName: 'test.tld',
        url: '',
        readingTime: 1,
        tags: ['tag1'],
        archivedAt: null,
      );
      final article2 = article1.copyWith(
        id: 2,
        domainName: const drift.Value('test2.tld'),
        tags: ['tag2'],
      );

      final LocalStorageService localStorageService = dependencies.get();

      await tester.pumpWidget(
        ProviderScope(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Consumer(
              builder: (context, ref, child) {
                return AsyncValueLoader(
                  value: ref.watch(queryStateProvider),
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text('resultCount: ${state.resultCount}'),
                        Text('availableDomains: ${state.availableDomains}'),
                        Text('availableTags: ${state.availableTags}'),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('resultCount: 0'), findsOneWidget);
      expect(find.text('availableDomains: []'), findsOneWidget);
      expect(find.text('availableTags: []'), findsOneWidget);

      await localStorageService.articles.update(article1);
      await tester.pumpAndSettle();

      expect(find.text('resultCount: 1'), findsOneWidget);
      expect(
        find.text('availableDomains: [${article1.domainName}]'),
        findsOneWidget,
      );
      expect(find.text('availableTags: ${article1.tags}'), findsOneWidget);

      await localStorageService.articles.update(article2);
      await tester.pumpAndSettle();

      expect(find.text('resultCount: 2'), findsOneWidget);
      expect(
        find.text(
          'availableDomains: ${[article1.domainName, article2.domainName]}',
        ),
        findsOneWidget,
      );
      expect(
        find.text('availableTags: ${article1.tags + article2.tags}'),
        findsOneWidget,
      );

      final QueryRepository queryRepository = dependencies.get();
      queryRepository.query = queryRepository.query.copyWith(
        domains: [article1.domainName!],
      );
      await tester.pumpAndSettle();

      expect(find.text('resultCount: 1'), findsOneWidget);
      expect(
        find.text('availableDomains: [${article1.domainName}]'),
        findsOneWidget,
      );
      expect(find.text('availableTags: ${article1.tags}'), findsOneWidget);
    });
  });
}
