import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/ui/core/widgets/navigation_split_view.dart';

import 'src/widget_tester_extension.dart';
import 'src/widgets.dart';

void main() {
  group('NavigationSplitView.itemCount changes', () {
    testWidgets('should update the navigation pane', (tester) async {
      final counter = ValueNotifier(3);

      await tester.pumpWidget(
        SimpleApp(
          child: NavigationSplitView(
            itemCount: counter,
            navigationItemBuilder: (context, index) => Text('Item $index'),
            contentBuilder: (context, index) => Text('Content $index'),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOne);
      expect(find.text('Item 5'), findsNothing);

      counter.value = 100;
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOne);
      expect(find.text('Item 5'), findsOne);
    });

    testWidgets('should not update the content pane', (tester) async {
      tester.setExpandedSize();

      final counter = ValueNotifier(3);
      int contentBuildCount = 0;

      await tester.pumpWidget(
        SimpleApp(
          child: NavigationSplitView(
            itemCount: counter,
            initialIndex: 1,
            navigationItemBuilder: (context, index) => Text('Item $index'),
            contentBuilder: (context, index) {
              contentBuildCount += index == 1 ? 1 : 0;
              return Text('Content $index');
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Content 1'), findsOne);

      counter.value = 100;
      await tester.pumpAndSettle();

      expect(find.text('Content 1'), findsOne);
      expect(contentBuildCount, 1);
    });

    testWidgets(
      'should reset the selected item without changing the content pane',
      (tester) async {
        tester.setExpandedSize();

        final counter = ValueNotifier(100);

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: counter,
              initialIndex: 50,
              navigationItemBuilder: (context, index) => Text('Item $index'),
              navigationItemExtent: 20,
              contentBuilder: (context, index) => Text('Content $index'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Item 1'), findsNothing);
        expect(find.text('Item 50'), findsOne);
        expect(find.text('Content 50'), findsOne);

        counter.value = 5;
        await tester.pumpAndSettle();

        expect(find.text('Item 1'), findsOne);
        expect(find.text('Item 50'), findsNothing);
        expect(find.text('Content 50'), findsOne);
      },
    );

    testWidgets(
      'should switch between the navigation pane and placeholder when the count pass by 0',
      (tester) async {
        const placeholderKey = Key('placeholder');
        final counter = ValueNotifier(3);

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: counter,
              navigationItemBuilder: (context, index) => Text('Item $index'),
              navigationPlaceholder: const SizedBox(key: placeholderKey),
              contentBuilder: (context, index) => Text('Content $index'),
            ),
          ),
        );

        expect(find.text('Item 0'), findsOne);
        expect(find.byKey(placeholderKey), findsNothing);

        counter.value = 0;
        await tester.pumpAndSettle();

        expect(find.text('Item 0'), findsNothing);
        expect(find.byKey(placeholderKey), findsOne);

        counter.value = 1;
        await tester.pumpAndSettle();

        expect(find.text('Item 0'), findsOne);
        expect(find.byKey(placeholderKey), findsNothing);
      },
    );
  });
}
