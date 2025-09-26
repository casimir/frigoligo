import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/ui/core/widgets/src/adaptive/window_query.dart';

void main() {
  group('WindowSizeClass.fromWidth', () {
    test('should return correct size class based on width breakpoints', () {
      expect(WindowSizeClass.fromWidth(500), equals(WindowSizeClass.compact));

      expect(WindowSizeClass.fromWidth(600), equals(WindowSizeClass.medium));
      expect(WindowSizeClass.fromWidth(700), equals(WindowSizeClass.medium));

      expect(WindowSizeClass.fromWidth(840), equals(WindowSizeClass.expanded));
      expect(WindowSizeClass.fromWidth(1000), equals(WindowSizeClass.expanded));

      expect(WindowSizeClass.fromWidth(1200), equals(WindowSizeClass.large));
      expect(WindowSizeClass.fromWidth(1400), equals(WindowSizeClass.large));

      expect(WindowSizeClass.fromWidth(1600), equals(WindowSizeClass.xlarge));
      expect(WindowSizeClass.fromWidth(3000), equals(WindowSizeClass.xlarge));
    });
  });

  group('WindowQueryData', () {
    test('should notify when size class changes', () {
      const oldData = WindowQueryData(
        sizeClass: WindowSizeClass.medium,
        child: SizedBox.shrink(),
      );
      const newData = WindowQueryData(
        sizeClass: WindowSizeClass.expanded,
        child: SizedBox.shrink(),
      );

      expect(newData.updateShouldNotify(oldData), isTrue);
    });

    test('should not notify when size class does not change', () {
      const oldData = WindowQueryData(
        sizeClass: WindowSizeClass.medium,
        child: SizedBox.shrink(),
      );
      const newData = WindowQueryData(
        sizeClass: WindowSizeClass.medium,
        child: SizedBox.shrink(),
      );

      expect(newData.updateShouldNotify(oldData), isFalse);
    });
  });

  group('WindowQuery', () {
    testWidgets('should adapt to different window sizes', (tester) async {
      String sizeClassLabel(WindowSizeClass sizeClass) =>
          'Size class: ${sizeClass.name}';

      void expectSizeClass(WindowSizeClass sizeClass) {
        expect(find.text(sizeClassLabel(sizeClass)), findsOneWidget);
      }

      tester.view.devicePixelRatio = 1;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: WindowQuery(
            child: Builder(
              builder: (context) {
                final info = WindowQuery.of(context);
                return Text(sizeClassLabel(info.sizeClass));
              },
            ),
          ),
        ),
      );

      tester.view.physicalSize = const Size(500, 800);
      await tester.pump();
      expectSizeClass(WindowSizeClass.compact);

      for (final width in [600.0, 700.0]) {
        tester.view.physicalSize = Size(width, 800);
        await tester.pump();
        expectSizeClass(WindowSizeClass.medium);
      }

      for (final width in [840.0, 1000.0]) {
        tester.view.physicalSize = Size(width, 800);
        await tester.pump();
        expectSizeClass(WindowSizeClass.expanded);
      }

      for (final width in [1200.0, 1400.0]) {
        tester.view.physicalSize = Size(width, 800);
        await tester.pump();
        expectSizeClass(WindowSizeClass.large);
      }

      for (final width in [1600.0, 3000.0]) {
        tester.view.physicalSize = Size(width, 800);
        await tester.pump();
        expectSizeClass(WindowSizeClass.xlarge);
      }
    });
  });
}
