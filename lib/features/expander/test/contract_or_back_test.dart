import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../src/actions/contract_or_back.dart';
import '../src/providers/expander.dart';

class TestIntent extends Intent {
  const TestIntent();
}

void main() {
  group('ContractOrBackAction', () {
    group('when expander is provided', () {
      testWidgets('should contract the expander when expanded', (tester) async {
        final expander = Expander(expanded: true);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final action = ContractOrBackAction(context, expander);
                action.invoke(const TestIntent());
                return const SizedBox();
              },
            ),
          ),
        );

        expect(expander.isExpanded, false);
      });

      testWidgets('should do nothing when not expanded', (tester) async {
        final expander = Expander();

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final action = ContractOrBackAction(context, expander);
                action.invoke(const TestIntent());
                return const SizedBox();
              },
            ),
          ),
        );

        expect(expander.isExpanded, false);
      });
    });

    group('when expander is not provided', () {
      testWidgets('should pop the navigation stack', (tester) async {
        const rootButtonLabel = 'Go to other';
        const otherLabel = 'Other page';

        Widget shortcutsWrapper(BuildContext context, Widget child) {
          return Shortcuts(
            shortcuts: const {
              SingleActivator(LogicalKeyboardKey.escape): TestIntent(),
            },
            child: Actions(
              actions: {TestIntent: ContractOrBackAction(context, null)},
              child: Focus(autofocus: true, child: child),
            ),
          );
        }

        await tester.pumpWidget(
          MaterialApp(
            routes: {
              '/': (context) {
                return shortcutsWrapper(
                  context,
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/other'),
                    child: const Text(rootButtonLabel),
                  ),
                );
              },
              '/other': (context) {
                return shortcutsWrapper(context, const Text('Other page'));
              },
            },
          ),
        );

        final buttonFinder = find.widgetWithText(
          ElevatedButton,
          rootButtonLabel,
        );

        // tap the button to go to the other page
        await tester.tap(buttonFinder);
        await tester.pumpAndSettle();
        expect(buttonFinder, findsNothing);
        expect(find.text(otherLabel), findsOneWidget);

        // check that sending the escape key pops the stack
        // run it 2 times, it should do nothing when the stack is empty
        for (var i = 0; i < 2; i++) {
          await tester.sendKeyEvent(LogicalKeyboardKey.escape);
          await tester.pumpAndSettle();
          expect(buttonFinder, findsOneWidget);
        }
      });
    });
  });
}
