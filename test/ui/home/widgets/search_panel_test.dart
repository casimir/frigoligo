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

    testWidgets('should allow to change the text search mode', (tester) async {
      when(() => mockController.setTextMode(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      final BuildContext context = tester.element(find.byType(SearchPanel));
      final l = AppLocalizations.of(context)!;

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.text(l.filters_searchMode), findsOneWidget);

      final titleOption = find.descendant(
        of: find.byType(ListView),
        matching: find.text(l.filters_searchModeTitle),
      );
      await tester.tap(titleOption);
      await tester.pumpAndSettle();

      verify(() => mockController.setTextMode(SearchTextMode.title)).called(1);
    });

    testWidgets('should allow to change the state filter', (tester) async {
      when(() => mockController.setState(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      final BuildContext context = tester.element(find.byType(SearchPanel));
      final l = AppLocalizations.of(context)!;

      await tester.tap(find.text(l.filters_articleStateAll));
      await tester.pumpAndSettle();

      final archivedOption = find.descendant(
        of: find.byType(ListView),
        matching: find.text(l.filters_articleStateArchived),
      );
      await tester.tap(archivedOption);
      await tester.pumpAndSettle();

      verify(() => mockController.setState(StateFilter.archived)).called(1);
    });

    testWidgets('should allow to change the starred filter', (tester) async {
      when(() => mockController.setOnlyStarred(any())).thenAnswer((_) async {});

      await tester.pumpWidget(
        buildWidget(query: const Query(onlyStarred: false)),
      );
      await tester.pumpAndSettle();

      final BuildContext context = tester.element(find.byType(SearchPanel));
      final l = AppLocalizations.of(context)!;

      await tester.tap(find.text(l.filters_articleFavoriteStarred));
      await tester.pumpAndSettle();

      verify(() => mockController.setOnlyStarred(true)).called(1);
    });

    testWidgets('should allow to select tags to filter', (tester) async {
      when(() => mockController.setTags(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildWidget(availableTags: ['tag1', 'tag2']));
      await tester.pumpAndSettle();

      // Scroll to tags filter and tap it
      final tagsFinder = find.byKey(kFilterTagsKey);
      await tester.scrollUntilVisible(
        tagsFinder,
        50.0,
        scrollable: find.descendant(
          of: find.byType(SearchPanel),
          matching: find.byType(Scrollable).first,
        ),
      );
      await tester.tap(tagsFinder);
      await tester.pumpAndSettle();

      // Select tags and confirm
      await tester.tap(find.text('tag1'));
      await tester.pumpAndSettle();
      await tester.tap(find.bySubtype<MaterialSheetActionButton>());
      await tester.pumpAndSettle();

      verify(() => mockController.setTags(['tag1'])).called(1);
    });

    testWidgets('should allow to select domains to filter', (tester) async {
      when(() => mockController.setDomains(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildWidget(availableDomains: ['domain1']));
      await tester.pumpAndSettle();

      final domainsFinder = find.byKey(kFilterDomainsKey);
      await tester.scrollUntilVisible(
        domainsFinder,
        50.0,
        scrollable: find.descendant(
          of: find.byType(SearchPanel),
          matching: find.byType(Scrollable).first,
        ),
      );
      await tester.tap(domainsFinder);
      await tester.pumpAndSettle();

      await tester.tap(find.text('domain1'));
      await tester.pumpAndSettle();
      await tester.tap(find.bySubtype<MaterialSheetActionButton>());
      await tester.pumpAndSettle();

      verify(() => mockController.setDomains(['domain1'])).called(1);
    });

    testWidgets('should allow to clear tag filter', (tester) async {
      when(() => mockController.setTags(any())).thenAnswer((_) async {});

      await tester.pumpWidget(
        buildWidget(query: const Query(tags: ['tag1', 'tag2'])),
      );
      await tester.pumpAndSettle();

      final tagsFinder = find.byKey(kFilterTagsKey);
      await tester.scrollUntilVisible(
        tagsFinder,
        50.0,
        scrollable: find.descendant(
          of: find.byType(SearchPanel),
          matching: find.byType(Scrollable).first,
        ),
      );

      // Tap the clear icon on the chip
      final clearIcon = find.descendant(
        of: tagsFinder,
        matching: find.byType(Icon),
      );
      await tester.tap(clearIcon);
      await tester.pumpAndSettle();

      verify(() => mockController.setTags([])).called(1);
    });
  });
}
