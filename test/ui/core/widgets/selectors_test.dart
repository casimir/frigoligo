import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/core/widgets/material_sheet.dart';
import 'package:frigoligo/ui/core/widgets/selectors.dart';

void main() {
  group('MultiSelect', () {
    final testEntries = [
      const DropdownMenuEntry(value: 'Item 1', label: 'Item 1'),
      const DropdownMenuEntry(value: 'Item 2', label: 'Item 2'),
      const DropdownMenuEntry(value: 'Item 3', label: 'Item 3'),
    ];

    Widget buildWidget({
      List<DropdownMenuEntry<String>>? entries,
      Set<String>? initialSelection,
      void Function(Iterable<String>)? onConfirm,
      Icon? addEntryIcon,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: MultiSelect<String>(
            title: 'Test Title',
            selectionLabelizer: (count) => '$count items',
            entries: entries ?? testEntries,
            initialSelection: initialSelection,
            onConfirm: onConfirm,
            addEntryIcon: addEntryIcon,
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
      );
    }

    testWidgets('should show initial selection', (tester) async {
      await tester.pumpWidget(
        buildWidget(initialSelection: {'Item 1', 'Item 2'}),
      );

      expect(find.byIcon(Icons.check), findsNWidgets(2));
      expect(find.text('Select 2 items'), findsOneWidget);
    });

    testWidgets('should allow selecting and deselecting items', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      expect(find.text('Select 0 items'), findsOneWidget);

      // Select item
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      expect(find.text('Select 1 items'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);

      // Deselect item
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      expect(find.text('Select 0 items'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('should filter entries based on search', (tester) async {
      await tester.pumpWidget(buildWidget());

      await tester.enterText(find.byType(TextField), '1');
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsNothing);
    });

    testWidgets('should clear search and selection with clear button', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());

      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'test');
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.clear_all));
      await tester.pumpAndSettle();

      expect(find.text('Select 0 items'), findsOneWidget);
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, isEmpty);
    });

    testWidgets('should call onConfirm when confirm button is pressed', (
      tester,
    ) async {
      Set<String>? confirmedSelection;
      await tester.pumpWidget(
        buildWidget(
          onConfirm: (selection) {
            confirmedSelection = selection.toSet();
          },
        ),
      );

      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Item 3'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(MaterialSheetActionButton));
      await tester.pumpAndSettle();

      expect(confirmedSelection, {'Item 1', 'Item 3'});
    });

    testWidgets('should allow adding new entries', (tester) async {
      await tester.pumpWidget(buildWidget(addEntryIcon: const Icon(Icons.add)));

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).last, 'New Item');
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('New Item'), findsOneWidget);
      expect(find.text('Select 1 items'), findsOneWidget);
    });
  });

  group('Select', () {
    final testEntries = [
      const DropdownMenuEntry(value: 1, label: 'Option 1'),
      const DropdownMenuEntry(value: 2, label: 'Option 2'),
      const DropdownMenuEntry(value: 3, label: 'Option 3'),
    ];

    Widget buildWidget({int? initial}) {
      return MaterialApp(
        home: Scaffold(
          body: Select<int>(
            title: 'Test Select',
            entries: testEntries,
            initial: initial,
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
      );
    }

    testWidgets('should mark initial selection with check icon', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget(initial: 2));

      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });

  group('SelectorChip', () {
    testWidgets('should display count with no selection', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SelectorChip<String>(
              selection: const [],
              onTap: () {},
              onDeleted: () {},
              labelizer: (count) => '$count tags',
            ),
          ),
        ),
      );

      expect(find.text('0 tags'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);

      final chip = tester.widget<FilterChip>(find.byType(FilterChip));
      expect(chip.selected, false);
    });

    testWidgets('should display count with selection', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SelectorChip<String>(
              selection: const ['tag1', 'tag2'],
              onTap: () {},
              onDeleted: () {},
              labelizer: (count) => '$count tags',
            ),
          ),
        ),
      );

      expect(find.text('2 tags'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_down), findsNothing);

      final chip = tester.widget<FilterChip>(find.byType(FilterChip));
      expect(chip.selected, true);
    });
  });

  group('SelectChip', () {
    final testEntries = [
      const DropdownMenuEntry(value: 1, label: 'Option 1'),
      const DropdownMenuEntry(value: 2, label: 'Option 2'),
      const DropdownMenuEntry(value: 3, label: 'Option 3'),
    ];

    testWidgets('should display initial selection label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SelectChip<int>(
              title: 'Choose',
              initialSelection: 1,
              onSelected: (_) {},
              entries: testEntries,
            ),
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);

      final chip = tester.widget<FilterChip>(find.byType(FilterChip));
      expect(chip.selected, false);
    });

    testWidgets('should display value when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SelectChip<int>(
              title: 'Choose',
              initialSelection: 1,
              value: 2,
              onSelected: (_) {},
              entries: testEntries,
            ),
          ),
        ),
      );

      expect(find.text('Option 2'), findsOneWidget);

      final chip = tester.widget<FilterChip>(find.byType(FilterChip));
      expect(chip.selected, true);
    });

    testWidgets('should open Select dialog when tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SelectChip<int>(
              title: 'Choose',
              initialSelection: 1,
              onSelected: (_) {},
              entries: testEntries,
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      );

      await tester.tap(find.byType(FilterChip));
      await tester.pumpAndSettle();

      // Dialog should open with title and options
      expect(find.text('Choose'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);
    });
  });

  group('search function', () {
    final entries = ['apple', 'banana', 'cherry', 'date', 'elderberry'];

    test('should return all entries when query is empty', () {
      final results = search('', entries);
      expect(results.length, entries.length);
      expect(results.map((e) => e.entry), containsAll(entries));
    });

    test('should filter entries by query', () {
      final results = search('a', entries);
      expect(results.map((e) => e.entry), contains('apple'));
      expect(results.map((e) => e.entry), isNot(contains('cherry')));
    });

    test('should be case insensitive', () {
      final results = search('APPLE', entries);
      expect(results.map((e) => e.entry), contains('apple'));
    });

    test('should handle multi-word queries', () {
      final results = search('a e', entries);
      expect(results.map((e) => e.entry), contains('apple'));
      expect(results.map((e) => e.entry), isNot(contains('banana')));
    });

    test('should boost selected items', () {
      final results = search('', entries, selected: {'banana'});
      expect(results.first.entry, 'banana');
      expect(results.first.score, greaterThan(results[1].score));
    });
  });

  group('showBottomSheetSelector', () {
    testWidgets('should show loading then MultiSelect when entries load', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    showBottomSheetSelector<String>(
                      context: context,
                      title: 'Select Items',
                      selectionLabelizer: (count) => '$count items',
                      entriesBuilder: Future.delayed(
                        const Duration(milliseconds: 100),
                        () => ['Item 1', 'Item 2'],
                      ),
                    );
                  },
                  child: const Text('Open'),
                ),
              );
            },
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text('Select Items'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.byType(MultiSelect<String>), findsOneWidget);
    });
  });

  group('showBottomSheetSelect', () {
    testWidgets('should show Select dialog', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    showBottomSheetSelect<int>(
                      context: context,
                      builder:
                          (ctx) => const Select<int>(
                            title: 'Choose Option',
                            entries: [
                              DropdownMenuEntry(value: 1, label: 'Option 1'),
                              DropdownMenuEntry(value: 2, label: 'Option 2'),
                            ],
                          ),
                    );
                  },
                  child: const Text('Open'),
                ),
              );
            },
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Choose Option'), findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
    });
  });
}
