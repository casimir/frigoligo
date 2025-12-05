import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/core/widgets/material_sheet.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

void main() {
  group('MaterialSheet', () {
    setUpAll(() {
      registerFallbackValue(FakeRoute());
    });

    final constructors = {
      'modal': MaterialSheet.modal,
      'side': MaterialSheet.side,
    };
    for (final mode in constructors.keys) {
      testWidgets('$mode should show a title and a close button', (
        tester,
      ) async {
        final mockNavigatorObserver = MockNavigatorObserver();
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                return constructors[mode]!(
                  context: context,
                  title: 'Title',
                  child: Container(),
                );
              },
            ),
            navigatorObservers: [mockNavigatorObserver],
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        );

        expect(find.text('Title'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.close));
        verify(() => mockNavigatorObserver.didPop(any(), any())).called(1);
      });
    }
  });

  group('MaterialSheetActionButton', () {
    testWidgets('should show a button with the given label', (tester) async {
      int pressedCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: MaterialSheetActionButton(
            label: 'Label',
            onPressed: () {
              pressedCount++;
            },
          ),
        ),
      );
      await tester.tap(find.text('Label'));
      expect(pressedCount, 1);
    });
  });
}
