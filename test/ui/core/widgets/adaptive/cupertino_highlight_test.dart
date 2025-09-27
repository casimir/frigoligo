import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/ui/core/widgets/src/adaptive/cupertino_highlight.dart';

void main() {
  group('adaptiveSplashFactory', () {
    Widget buildWidget(
      TargetPlatform platform,
      void Function(InteractiveInkFeatureFactory?) onValue,
    ) {
      return MaterialApp(
        theme: ThemeData(platform: platform),
        home: Builder(
          builder: (context) {
            onValue(adaptiveSplashFactory(context));
            return const SizedBox();
          },
        ),
      );
    }

    testWidgets('should return the splashFactory on iOS and macOS', (
      tester,
    ) async {
      for (final platform in [TargetPlatform.iOS, TargetPlatform.macOS]) {
        await tester.pumpWidget(
          buildWidget(platform, (value) {
            expect(value, equals(CupertinoHighlight.splashFactory));
          }),
        );
      }
    });

    testWidgets('should return null on other platforms', (tester) async {
      for (final platform in [
        TargetPlatform.android,
        TargetPlatform.linux,
        TargetPlatform.windows,
        TargetPlatform.fuchsia,
      ]) {
        await tester.pumpWidget(
          buildWidget(platform, (value) {
            expect(value, isNull);
          }),
        );
      }
    });

    testWidgets(
      'should work with InkWell without crashing',
      (tester) async {
        await tester.pumpWidget(
          CupertinoApp(
            theme: const CupertinoThemeData(),
            home: Material(
              child: Builder(
                builder: (context) {
                  return InkWell(
                    splashFactory: CupertinoHighlight.splashFactory,
                    onTap: () {},
                    child: const SizedBox(),
                  );
                },
              ),
            ),
          ),
        );

        // trigger a ripple effect to ensure the factory is used
        await tester.tap(find.byType(InkWell));
        await tester.pumpAndSettle();
      },
      variant: TargetPlatformVariant.only(TargetPlatform.iOS),
    );
  });
}
