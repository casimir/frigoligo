import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/ui/core/widgets/navigation_split_view.dart';

import 'src/widget_tester_extension.dart';
import 'src/widgets.dart';

void main() {
  group('NavigationSplitView builders >', () {
    group('Navigation builder >', () {
      testWidgets('It should build navigation items correctly', (tester) async {
        tester.setExpandedSize();

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: ValueNotifier(3),
              navigationItemBuilder:
                  (context, index) => Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.abc),
                      Flexible(child: Text('Item $index')),
                    ],
                  ),
              contentBuilder: (context, index) => Text('Content $index'),
            ),
          ),
        );

        expect(find.text('Item 0'), findsOneWidget);
        expect(find.text('Item 1'), findsOneWidget);
        expect(find.text('Item 2'), findsOneWidget);
        expect(find.byIcon(Icons.abc), findsNWidgets(3));
      });

      testWidgets('It should use the custom container when provided', (
        tester,
      ) async {
        const customKey = Key('navigation-container');

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: ValueNotifier(1),
              navigationItemBuilder: (context, index) => Text('Item $index'),
              contentBuilder: (context, index) => const Placeholder(),
              navigationContainerBuilder:
                  (context, selectedIndex, child) =>
                      Container(key: customKey, child: child),
            ),
          ),
        );

        expect(
          find.ancestor(
            of: find.text('Item 0'),
            matching: find.byKey(customKey),
          ),
          findsOneWidget,
        );
      });

      testWidgets('It should build navigation placeholder correctly', (
        tester,
      ) async {
        tester.setExpandedSize();

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: ValueNotifier(0),
              navigationItemBuilder: (context, index) => const Placeholder(),
              contentBuilder: (context, index) => const Placeholder(),
            ),
          ),
        );

        expect(find.text('No items'), findsOneWidget);
      });

      testWidgets('It should use the custom placeholder when provided', (
        tester,
      ) async {
        tester.setExpandedSize();

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: ValueNotifier(0),
              navigationItemBuilder: (context, index) => const Placeholder(),
              navigationPlaceholder: const Center(
                child: Text('Custom placeholder'),
              ),
              contentBuilder: (context, index) => const Placeholder(),
            ),
          ),
        );

        expect(find.text('Custom placeholder'), findsOneWidget);
      });

      testWidgets(
        'It should handle navigation item taps (side-by-side layout)',
        (tester) async {
          tester.setExpandedSize();

          int? callbackIndexValue;

          await tester.pumpWidget(
            SimpleApp(
              child: NavigationSplitView(
                itemCount: ValueNotifier(2),
                navigationItemBuilder:
                    (context, index) => ListTile(title: Text('Item $index')),
                contentBuilder: (context, index) => Text('Content $index'),
                onSelectedIndexChanged: (index) => callbackIndexValue = index,
              ),
            ),
          );

          // Initially the first item should be selected
          expect(find.text('Content 0'), findsOneWidget);
          expect(callbackIndexValue, null);

          await tester.tap(find.text('Item 1'));
          await tester.pump();

          expect(find.text('Content 1'), findsOneWidget);
          expect(callbackIndexValue, 1);
        },
      );

      testWidgets('It should handle navigation item taps (full layout)', (
        tester,
      ) async {
        tester.setMediumSize();

        int? callbackIndexValue;

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: ValueNotifier(2),
              navigationItemBuilder:
                  (context, index) => ListTile(title: Text('Item $index')),
              contentBuilder: (context, index) => Text('Content $index'),
              onSelectedIndexChanged: (index) => callbackIndexValue = index,
            ),
          ),
        );

        await tester.tap(find.text('Item 1'));
        await tester.pumpAndSettle();

        expect(find.text('Item 1'), findsNothing);
        expect(find.text('Content 1'), findsOneWidget);
        expect(callbackIndexValue, 1);

        final navigator = tester.state<NavigatorState>(find.byType(Navigator));
        navigator.pop();
        await tester.pumpAndSettle();

        expect(find.text('Item 1'), findsOneWidget);
        expect(find.text('Content 1'), findsNothing);
      });

      testWidgets(
        'It should handle initialIndex correctly (side-by-side layout)',
        (tester) async {
          tester.setExpandedSize();

          int contentBuildCount = 0;

          await tester.pumpWidget(
            SimpleApp(
              child: NavigationSplitView(
                itemCount: ValueNotifier(3),
                initialIndex: 2,
                navigationItemBuilder: (context, index) => Text('Item $index'),
                contentBuilder: (context, index) {
                  contentBuildCount += index == 2 ? 1 : 0;
                  return Text('Content $index');
                },
              ),
            ),
          );
          // allow the widget to execute any post-frame callbacks
          await tester.pumpAndSettle();

          expect(find.text('Content 2'), findsOneWidget);
          expect(contentBuildCount, 1);
        },
      );

      testWidgets('It should handle initialIndex correctly (full layout)', (
        tester,
      ) async {
        tester.setMediumSize();

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: ValueNotifier(3),
              initialIndex: 2,
              navigationItemBuilder: (context, index) => Text('Item $index'),
              contentBuilder: (context, index) => Text('Content $index'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Item 2'), findsNothing);
        expect(find.text('Content 2'), findsOneWidget);
      });

      testWidgets('It should handle negative initialIndex values', (
        tester,
      ) async {
        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: ValueNotifier(3),
              navigationItemBuilder: (context, index) => const Placeholder(),
              contentBuilder: (context, index) => const Placeholder(),
              initialIndex: -1,
            ),
          ),
        );

        expect(tester.takeException(), isA<AssertionError>());
      });

      testWidgets('It should handle out of bounds initialIndex values', (
        tester,
      ) async {
        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: ValueNotifier(3),
              navigationItemBuilder: (context, index) => const Placeholder(),
              contentBuilder: (context, index) => const Placeholder(),
              initialIndex: 100,
            ),
          ),
        );

        expect(tester.takeException(), isA<AssertionError>());
      });
    });

    group('Content builder >', () {
      testWidgets('It should build content placeholder correctly', (
        tester,
      ) async {
        tester.setExpandedSize();

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: ValueNotifier(0),
              navigationItemBuilder: (context, index) => const Placeholder(),
              contentBuilder: (context, index) => const Placeholder(),
            ),
          ),
        );

        expect(find.text('Select an item'), findsOneWidget);
      });

      testWidgets('It should use the custom placeholder when provided', (
        tester,
      ) async {
        tester.setExpandedSize();

        await tester.pumpWidget(
          SimpleApp(
            child: NavigationSplitView(
              itemCount: ValueNotifier(0),
              navigationItemBuilder: (context, index) => const Placeholder(),
              contentBuilder: (context, index) => const Placeholder(),
              contentPlaceholder: const Center(
                child: Text('Custom placeholder'),
              ),
            ),
          ),
        );

        expect(find.text('Custom placeholder'), findsOneWidget);
      });
    });
  });
}
