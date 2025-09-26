import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/ui/core/widgets/navigation_split_view.dart';

import 'src/widget_tester_extension.dart';
import 'src/widgets.dart';

void main() {
  group('The selected navigation item', () {
    testWidgets('should be highlighted (side-by-side layout)', (tester) async {
      const highlightColor = Color(0xFF00FF00);

      tester.setExpandedSize();

      await tester.pumpWidget(
        SimpleApp(
          child: NavigationSplitView(
            itemCount: ValueNotifier(1),
            navigationItemBuilder:
                (context, index) => const Text(navigationLabel),
            contentBuilder: (context, index) => const Text(contentLabel),
            highlightColor: highlightColor,
          ),
        ),
      );

      expect(
        tester
            .widget<Ink>(
              find.ancestor(
                of: find.text(navigationLabel),
                matching: find.byType(Ink),
              ),
            )
            .decoration,
        isA<BoxDecoration>().having(
          (decoration) => decoration.color,
          'color',
          highlightColor,
        ),
      );
    });

    testWidgets('should not be highlighted (full layout)', (tester) async {
      tester.setMediumSize();

      await tester.pumpWidget(
        const SimpleApp(child: SimpleNavigationSplitView()),
      );

      expect(
        tester
            .widget<Ink>(
              find.ancestor(
                of: find.text(navigationLabel),
                matching: find.byType(Ink),
              ),
            )
            .decoration,
        isNull,
      );
    });
  });

  group('NavigationSplitView navigation pane', () {
    testWidgets('should scroll to the selected item (side-by-side layout)', (
      tester,
    ) async {
      tester.setExpandedSize();

      await tester.pumpWidget(
        SimpleApp(
          child: NavigationSplitView(
            itemCount: ValueNotifier(100),
            navigationItemBuilder: (context, index) => Text('Item $index'),
            navigationItemExtent: 20,
            contentBuilder: (context, index) => Text('Content $index'),
            initialIndex: 99,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Item 0'), findsNothing);
      expect(find.text('Item 99'), findsOneWidget);
    });

    testWidgets(
      'should keep the selected item visible when toggling content pane expansion',
      (tester) async {
        tester.setExpandedSize();

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: ValueNotifier(100),
              navigationItemBuilder: (context, index) => Text('Item $index'),
              navigationItemExtent: 20,
              contentBuilder: (context, index) => Text('Content $index'),
              initialIndex: 53,
            ),
          ),
        );

        await tester.pumpAndSettle();

        final view = tester.state<NavigationSplitViewState>(
          find.byType(NavigationSplitView),
        );

        expect(find.text('Item 53'), findsOneWidget);

        view.toggleContentExpansion();
        await tester.pumpAndSettle();
        view.toggleContentExpansion();
        await tester.pumpAndSettle();

        expect(find.text('Item 0'), findsNothing);
        expect(find.text('Item 53'), findsOneWidget);
      },
    );
  });
}
