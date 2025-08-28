import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/ui/core/ui/navigation_split_view/navigation_split_view.dart';

import 'src/widget_tester_extension.dart';
import 'src/widgets.dart';

void main() {
  group('ExpandedContentButton ', () {
    testWidgets(
      'should toggle content expansion when tapped (side-by-side layout)',
      (tester) async {
        tester.setExpandedSize();

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: 1,
              navigationItemBuilder: (context, index) => Text('Item $index'),
              contentBuilder:
                  (context, index) => Scaffold(
                    appBar: AppBar(leading: const ExpandContentButton()),
                    body: Text('Content $index'),
                  ),
            ),
          ),
        );

        expect(find.byIcon(Icons.expand_more), findsOneWidget);
        expect(find.text('Item 0'), findsOneWidget);
        expect(find.text('Content 0'), findsOneWidget);

        await tester.tap(find.byType(ExpandContentButton));
        await tester.pump();

        expect(find.byIcon(Icons.expand_less), findsOneWidget);
        expect(find.text('Item 0'), findsNothing);
        expect(find.text('Content 0'), findsOneWidget);

        await tester.tap(find.byType(ExpandContentButton));
        await tester.pump();

        expect(find.byIcon(Icons.expand_more), findsOneWidget);
        expect(find.text('Item 0'), findsOneWidget);
        expect(find.text('Content 0'), findsOneWidget);
      },
    );

    testWidgets('should pop the navigation stack when tapped (full layout)', (
      tester,
    ) async {
      tester.setMediumSize();

      await tester.pumpWidget(
        SimpleApp(
          child: NavigationSplitView(
            itemCount: 1,
            navigationItemBuilder: (context, index) => Text('Item $index'),
            contentBuilder:
                (context, index) => Scaffold(
                  appBar: AppBar(leading: const ExpandContentButton()),
                  body: Text('Content $index'),
                ),
            initialIndex: 0,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byTooltip('Back'), findsOneWidget);
      expect(find.text('Content 0'), findsOneWidget);
      expect(find.text('Item 0'), findsNothing);

      await tester.tap(find.byType(ExpandContentButton));
      await tester.pumpAndSettle();

      expect(find.byTooltip('Back'), findsNothing);
      expect(find.text('Content 0'), findsNothing);
      expect(find.text('Item 0'), findsOneWidget);
    });
  });
}
