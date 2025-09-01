import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/ui/core/ui/navigation_split_view.dart';

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
            itemCount: 1,
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
}
