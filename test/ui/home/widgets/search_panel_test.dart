import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/domain/models/query.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/core/widgets/material_sheet.dart';
import 'package:frigoligo/ui/core/widgets/src/navigation_split_view/animated_navigation_pane_slider.dart';
import 'package:frigoligo/ui/home/controllers/search_panel_controller.dart';
import 'package:frigoligo/ui/home/states.dart';
import 'package:frigoligo/ui/home/widgets/search_panel.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchPanelController extends Mock implements SearchPanelController {}

void main() {
  Finder findEntry(String label) {
    return find.descendant(
      of: find.byType(ListView),
      matching: find.text(label),
    );
  }

  Future<void> scrollFilterIntoView(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(
      finder,
      50.0,
      scrollable: find.descendant(
        of: find.byType(SearchPanel),
        matching: find.byType(Scrollable).first,
      ),
    );
  }

  setUpAll(() {
    registerFallbackValue(SearchTextMode.all);
    registerFallbackValue(StateFilter.all);
  });

  group('SearchPanel', () {
    late MockSearchPanelController mockController;

    setUp(() {
      mockController = MockSearchPanelController();
    });

    group('(state loading)', () {
      // The default widgets from [FutureLoader] are too big for this widget. This
      // test groups checks that the custom widgets render correctly.

      Widget buildFutureWidget(Completer<QueryState> completer) {
        return ProviderScope(
          overrides: [
            // ignore: scoped_providers_should_specify_dependencies
            queryStateProvider.overrideWith((ref) => completer.future),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: kNavigationPaneWidth,
                child: SearchPanel(controller: mockController),
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        );
      }

      testWidgets('should show a loading indicator while state is loading', (
        tester,
      ) async {
        final completer = Completer<QueryState>();

        await tester.pumpWidget(buildFutureWidget(completer));
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('should show an error when the state loading fails', (
        tester,
      ) async {
        final completer = Completer<QueryState>();

        await tester.pumpWidget(buildFutureWidget(completer));
        completer.completeError(Exception('test error'));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.error_outline), findsAtLeastNWidgets(1));
      });
    });

    Widget buildWidget({
      Query query = const Query(),
      int resultCount = 0,
      List<String> availableDomains = const [],
      List<String> availableTags = const [],
    }) {
      final state = QueryState(
        query: query,
        resultCount: resultCount,
        availableDomains: availableDomains,
        availableTags: availableTags,
      );
      return ProviderScope(
        overrides: [
          // ignore: scoped_providers_should_specify_dependencies
          queryStateProvider.overrideWith((ref) => state),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: kNavigationPaneWidth,
              child: SearchPanel(controller: mockController),
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      );
    }

    testWidgets('should show the result count', (tester) async {
      await tester.pumpWidget(buildWidget(resultCount: 3));
      await tester.pumpAndSettle();

      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('should update the query when the text is changed', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      final BuildContext context = tester.element(find.byType(SearchPanel));
      final l = AppLocalizations.of(context)!;

      expect(find.text(l.filters_searchbarHint), findsOneWidget);

      await tester.enterText(find.byType(SearchBar), 'test1');
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(SearchBar), 'test2');
      await tester.pumpAndSettle();

      verify(() => mockController.setText('test1')).called(1);
      verify(() => mockController.setText('test2')).called(1);
    });

    testWidgets('should display a different icon for each text mode', (
      tester,
    ) async {
      Set<IconData> icons = {};

      for (final textMode in SearchTextMode.values) {
        await tester.pumpWidget(buildWidget(query: Query(textMode: textMode)));
        await tester.pumpAndSettle();

        final BuildContext context = tester.element(find.byType(SearchPanel));
        final container = ProviderScope.containerOf(context);
        final l = AppLocalizations.of(context)!;

        final iconFinder = find.descendant(
          of: find.byWidgetPredicate(
            (widget) =>
                widget is Tooltip && widget.message == l.filters_searchMode,
          ),
          matching: find.byType(Icon),
        );
        icons.add(tester.widget<Icon>(iconFinder).icon!);

        container.invalidate(queryStateProvider);
      }

      expect(icons.length, equals(3));
    });

    testWidgets('should allow to change the text search mode', (tester) async {
      when(() => mockController.setTextMode(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      final BuildContext context = tester.element(find.byType(SearchPanel));
      final l = AppLocalizations.of(context)!;

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.text(l.filters_searchMode), findsOneWidget);
      expect(findEntry(l.filters_searchModeAll), findsOneWidget);
      expect(findEntry(l.filters_searchModeTitle), findsOneWidget);
      expect(findEntry(l.filters_searchModeContent), findsOneWidget);

      await tester.tap(findEntry(l.filters_searchModeTitle));
      await tester.pumpAndSettle();

      expect(find.text(l.filters_searchMode), findsNothing);
      verify(() => mockController.setTextMode(SearchTextMode.title)).called(1);

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
      await tester.tap(findEntry(l.filters_searchModeContent));
      await tester.pumpAndSettle();

      expect(find.text(l.filters_searchMode), findsNothing);
      verify(
        () => mockController.setTextMode(SearchTextMode.content),
      ).called(1);

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
      await tester.tap(findEntry(l.filters_searchModeAll));
      await tester.pumpAndSettle();

      expect(find.text(l.filters_searchMode), findsNothing);
      verify(() => mockController.setTextMode(SearchTextMode.all)).called(1);
    });

    testWidgets('should display the current state filter', (tester) async {
      for (final stateValue in StateFilter.values) {
        await tester.pumpWidget(buildWidget(query: Query(state: stateValue)));
        await tester.pumpAndSettle();

        final BuildContext context = tester.element(find.byType(SearchPanel));
        final container = ProviderScope.containerOf(context);
        final l = AppLocalizations.of(context)!;

        final stateLabel = switch (stateValue) {
          StateFilter.all => l.filters_articleStateAll,
          StateFilter.unread => l.filters_articleStateUnread,
          StateFilter.archived => l.filters_articleStateArchived,
        };
        expect(find.text(stateLabel), findsOneWidget);

        container.invalidate(queryStateProvider);
      }
    });

    testWidgets('should allow to change the state filter', (tester) async {
      when(() => mockController.setState(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      final BuildContext context = tester.element(find.byType(SearchPanel));
      final l = AppLocalizations.of(context)!;

      Future<void> openSelector() async {
        // Query.state defaults to StateFilter.all
        await tester.tap(find.text(l.filters_articleStateAll));
        await tester.pumpAndSettle();
      }

      await openSelector();

      expect(find.text(l.filters_articleState), findsOneWidget);
      for (final label in [
        l.filters_articleStateAll,
        l.filters_articleStateArchived,
        l.filters_articleStateUnread,
      ]) {
        expect(findEntry(label), findsOneWidget);
      }

      await tester.tap(findEntry(l.filters_articleStateArchived));
      await tester.pumpAndSettle();

      expect(find.text(l.filters_articleState), findsNothing);
      verify(() => mockController.setState(StateFilter.archived)).called(1);

      await openSelector();
      await tester.tap(findEntry(l.filters_articleStateUnread));
      await tester.pumpAndSettle();

      expect(find.text(l.filters_articleState), findsNothing);
      verify(() => mockController.setState(StateFilter.unread)).called(1);

      await openSelector();
      await tester.tap(findEntry(l.filters_articleStateAll));
      await tester.pumpAndSettle();

      expect(find.text(l.filters_articleState), findsNothing);
      verify(() => mockController.setState(StateFilter.all)).called(1);
    });

    testWidgets('should allow to change the starred filter', (tester) async {
      when(() => mockController.setOnlyStarred(any())).thenAnswer((_) async {});

      for (final starred in [false, true]) {
        await tester.pumpWidget(
          buildWidget(query: Query(onlyStarred: starred)),
        );
        await tester.pumpAndSettle();

        final BuildContext context = tester.element(find.byType(SearchPanel));
        final container = ProviderScope.containerOf(context);
        final l = AppLocalizations.of(context)!;

        await tester.tap(find.text(l.filters_articleFavoriteStarred));
        await tester.pumpAndSettle();

        verify(() => mockController.setOnlyStarred(!starred)).called(1);

        container.invalidate(queryStateProvider);
      }
    });

    testWidgets('should display the current tags filter', (tester) async {
      final List<List<String>> tagsValues = [
        [],
        ['tag1', 'tag2'],
      ];

      for (final tags in tagsValues) {
        await tester.pumpWidget(buildWidget(query: Query(tags: tags)));
        await tester.pumpAndSettle();

        final BuildContext context = tester.element(find.byType(SearchPanel));
        final container = ProviderScope.containerOf(context);
        final l = AppLocalizations.of(context)!;

        final label =
            tags.isEmpty
                ? l.filters_articleTags
                : l.filters_articleTagsCount(tags.length);
        expect(find.text(label), findsOneWidget);

        container.invalidate(queryStateProvider);
      }
    });

    testWidgets('should allow to select tags to filter', (tester) async {
      final testTags = ['tag1', 'tag2'];

      when(() => mockController.setTags(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildWidget(availableTags: testTags));
      await tester.pumpAndSettle();

      final finder = find.byKey(kFilterTagsKey);
      await scrollFilterIntoView(tester, finder);
      await tester.tap(finder);
      await tester.pumpAndSettle();

      for (final tag in testTags) {
        await tester.tap(findEntry(tag));
        await tester.pumpAndSettle();
      }
      await tester.tap(find.bySubtype<MaterialSheetActionButton>());
      await tester.pumpAndSettle();

      verify(() => mockController.setTags(testTags)).called(1);
    });

    testWidgets('should display the current domains filter', (tester) async {
      final List<List<String>> domainsValues = [
        [],
        ['domain1', 'domain2'],
      ];

      for (final domains in domainsValues) {
        await tester.pumpWidget(buildWidget(query: Query(domains: domains)));
        await tester.pumpAndSettle();

        final BuildContext context = tester.element(find.byType(SearchPanel));
        final container = ProviderScope.containerOf(context);
        final l = AppLocalizations.of(context)!;

        final label =
            domains.isEmpty
                ? l.filters_articleDomains
                : l.filters_articleDomainsCount(domains.length);
        expect(find.text(label), findsOneWidget);

        container.invalidate(queryStateProvider);
      }
    });

    testWidgets('should allow to select domains to filter', (tester) async {
      final testDomains = ['domain1', 'domain2'];

      when(() => mockController.setDomains(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildWidget(availableDomains: testDomains));
      await tester.pumpAndSettle();

      final finder = find.byKey(kFilterDomainsKey);
      await scrollFilterIntoView(tester, finder);
      await tester.tap(finder);
      await tester.pumpAndSettle();

      for (final domain in testDomains) {
        await tester.tap(findEntry(domain));
        await tester.pumpAndSettle();
      }
      await tester.tap(find.bySubtype<MaterialSheetActionButton>());
      await tester.pumpAndSettle();

      verify(() => mockController.setDomains(testDomains)).called(1);
    });

    testWidgets('should allow to clear multiselect filters', (tester) async {
      when(() => mockController.setTags(any())).thenAnswer((_) async {});
      when(() => mockController.setDomains(any())).thenAnswer((_) async {});

      await tester.pumpWidget(
        buildWidget(
          query: const Query(
            tags: ['tag1', 'tag2'],
            domains: ['domain1', 'domain2'],
          ),
        ),
      );
      await tester.pumpAndSettle();

      const filterChipKeys = [kFilterTagsKey, kFilterDomainsKey];
      for (final key in filterChipKeys) {
        final finder = find.byKey(key);
        await scrollFilterIntoView(tester, finder);
        await tester.tap(
          find.descendant(of: finder, matching: find.byType(Icon)),
        );
        await tester.pumpAndSettle();
      }

      verify(() => mockController.setTags([])).called(1);
      verify(() => mockController.setDomains([])).called(1);
    });
  });
}
