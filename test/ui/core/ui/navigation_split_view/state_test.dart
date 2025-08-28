import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/ui/core/ui/navigation_split_view/navigation_split_view.dart';

import 'src/widget_tester_extension.dart';
import 'src/widgets.dart';

void main() {
  group('NavigationSplitViewState', () {
    testWidgets(
      'should select the correct index when selectIndex is called (side-by-side layout)',
      (tester) async {
        tester.setExpandedSize();

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: 3,
              navigationItemBuilder: (context, index) => Text('Item $index'),
              contentBuilder: (context, index) => Text('Content $index'),
            ),
          ),
        );

        final splitView = tester.state<NavigationSplitViewState>(
          find.byType(NavigationSplitView),
        );

        expect(find.text('Content 0'), findsOneWidget);

        splitView.selectIndex(2);
        await tester.pump();

        expect(find.text('Content 2'), findsOneWidget);

        splitView.selectIndex(null);
        await tester.pump();

        expect(find.text('Select an item'), findsOneWidget);
      },
    );
  });

  testWidgets(
    'should select the correct index when selectIndex is called (full layout)',
    (tester) async {
      tester.setMediumSize();

      await tester.pumpWidget(
        SimpleApp(
          child: NavigationSplitView(
            itemCount: 3,
            navigationItemBuilder: (context, index) => Text('Item $index'),
            contentBuilder: (context, index) => Text('Content $index'),
          ),
        ),
      );

      final splitView = tester.state<NavigationSplitViewState>(
        find.byType(NavigationSplitView),
      );

      expect(find.text('Item 2'), findsOneWidget);

      splitView.selectIndex(2);
      await tester.pumpAndSettle();

      expect(find.text('Content 2'), findsOneWidget);

      final navigator = tester.state<NavigatorState>(find.byType(Navigator));
      navigator.pop();
      await tester.pumpAndSettle();

      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Content 2'), findsNothing);
    },
  );

  testWidgets('should change layout when toggleContentExpansion is called', (
    tester,
  ) async {
    tester.setExpandedSize();

    await tester.pumpWidget(
      const SimpleApp(child: SimpleNavigationSplitView()),
    );

    final view = tester.state<NavigationSplitViewState>(
      find.byType(NavigationSplitView),
    );

    expect(view.isContentExpanded, isFalse);
    expectSideBySideLayout(tester);

    view.toggleContentExpansion();
    await tester.pump();

    expect(view.isContentExpanded, isTrue);
    expectContentFullLayout(tester);

    view.toggleContentExpansion();
    await tester.pump();

    expect(view.isContentExpanded, isFalse);
    expectSideBySideLayout(tester);
  });
}
