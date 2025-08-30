import 'package:cadanse/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'src/widget_tester_extension.dart';
import 'src/widgets.dart';

void main() {
  group('NavigationSplitView layout >', () {
    group('Breakpoint-based layout >', () {
      testWidgets(
        'It should use side-by-side layout for expanded window class',
        (tester) async {
          tester.setExpandedSize();

          await tester.pumpWidget(
            const MaterialApp(home: SimpleNavigationSplitView()),
          );

          expectSimpleSideBySideLayout(tester);
        },
      );

      testWidgets('It should use full layout for other window classes', (
        tester,
      ) async {
        tester.setMediumSize();

        await tester.pumpWidget(
          const MaterialApp(home: SimpleNavigationSplitView()),
        );

        expectSimpleNavigationFullLayout(tester);
      });
    });

    group('Resize behavior >', () {
      testWidgets(
        'It should transition from side-by-side to full layout when resizing down',
        (tester) async {
          tester.setExpandedSize();

          await tester.pumpWidget(
            const MaterialApp(home: SimpleNavigationSplitView()),
          );

          expectSimpleSideBySideLayout(tester);

          tester.setMediumSize();
          await tester.pump();

          expectSimpleNavigationFullLayout(tester);
        },
      );

      testWidgets(
        'It should transition from full to side-by-side layout when resizing up',
        (tester) async {
          tester.setMediumSize();

          await tester.pumpWidget(
            const MaterialApp(home: SimpleNavigationSplitView()),
          );

          expectSimpleNavigationFullLayout(tester);

          tester.setExpandedSize();
          await tester.pump();

          expectSimpleSideBySideLayout(tester);
        },
      );

      testWidgets('It should handle multiple resize operations correctly', (
        tester,
      ) async {
        tester.setExpandedSize();

        await tester.pumpWidget(
          const MaterialApp(home: SimpleNavigationSplitView()),
        );

        const testSizes = [
          Size(700, 600), // medium
          Size(900, 600), // expanded
          Size(800, 600), // medium
        ];

        for (final size in testSizes) {
          tester.setSize(size);
          await tester.pump();

          if (size.width >= expandedBreakpoint) {
            expectSimpleSideBySideLayout(tester);
          } else {
            expectSimpleNavigationFullLayout(tester);
          }
        }
      });
    });
  });
}
