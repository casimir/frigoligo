import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/ui/core/widgets/src/navigation_split_view/navigation_split_view.dart';

import 'src/widget_tester_extension.dart';
import 'src/widgets.dart';

void main() {
  group('NavigationSplitView shortcuts >', () {
    group('Side-by-side layout >', () {
      testWidgets('It should expand content pane when F key is pressed', (
        tester,
      ) async {
        tester.setExpandedSize();

        await tester.pumpWidget(
          const SimpleApp(child: SimpleNavigationSplitView()),
        );

        expectSimpleSideBySideLayout(tester);

        await tester.sendKeyEvent(LogicalKeyboardKey.keyF);
        await tester.pumpAndSettle();

        expectSimpleContentFullLayout(tester);

        await tester.sendKeyEvent(LogicalKeyboardKey.keyF);
        await tester.pumpAndSettle();

        expectSimpleContentFullLayout(tester);
      });

      testWidgets(
        'It should collapse content pane when Escape key is pressed',
        (tester) async {
          tester.setExpandedSize();

          await tester.pumpWidget(
            const SimpleApp(child: SimpleNavigationSplitView()),
          );

          final view = tester.state<NavigationSplitViewState>(
            find.byType(NavigationSplitView),
          );
          view.expandContent();
          await tester.pumpAndSettle();

          expectSimpleContentFullLayout(tester);

          await tester.sendKeyEvent(LogicalKeyboardKey.escape);
          await tester.pumpAndSettle();

          expectSimpleSideBySideLayout(tester);

          await tester.sendKeyEvent(LogicalKeyboardKey.escape);
          await tester.pumpAndSettle();

          expectSimpleSideBySideLayout(tester);
        },
      );

      testWidgets('It should do nothing if shortcuts are disabled', (
        tester,
      ) async {
        tester.setExpandedSize();

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: ValueNotifier(1),
              navigationItemBuilder:
                  (context, index) => const Text(navigationLabel),
              contentBuilder: (context, index) => const Text(contentLabel),
              enableShortcuts: false,
            ),
          ),
        );

        expectSimpleSideBySideLayout(tester);

        await tester.sendKeyEvent(LogicalKeyboardKey.keyF);
        await tester.pumpAndSettle();

        expectSimpleSideBySideLayout(tester);
      });
    });

    group('Full layout >', () {
      testWidgets('It should pop navigation stack when Escape key is pressed', (
        tester,
      ) async {
        tester.setMediumSize();

        await tester.pumpWidget(
          const SimpleApp(child: SimpleNavigationSplitView()),
        );

        await tester.tap(find.text(navigationLabel));
        await tester.pumpAndSettle();

        expectSimpleContentFullLayout(tester);

        await tester.sendKeyEvent(LogicalKeyboardKey.escape);
        await tester.pumpAndSettle();

        expectSimpleNavigationFullLayout(tester);

        await tester.sendKeyEvent(LogicalKeyboardKey.escape);
        await tester.pumpAndSettle();

        expectSimpleNavigationFullLayout(tester);
      });
    });
  });
}
