import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/ui/core/widgets/src/adaptive/adaptive_page_route.dart';

void main() {
  group('AppType.detect', () {
    setUp(() {
      AppType.clearCache();
    });

    testWidgets('should detect a MaterialApp parent', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final appType = AppType.detect(context);
              expect(appType, equals(AppType.material));
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('should detect a CupertinoApp parent', (tester) async {
      await tester.pumpWidget(
        CupertinoApp(
          home: Builder(
            builder: (context) {
              final appType = AppType.detect(context);
              expect(appType, equals(AppType.cupertino));
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('should fallback to AppType.widgets', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              final appType = AppType.detect(context);
              expect(appType, equals(AppType.widgets));
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('should cache detection result and reuse it', (tester) async {
      late AppType result1, result2;
      bool firstCallWasCacheMiss = false;
      bool secondCallWasCacheMiss = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              result1 = AppType.detectWithCallback(context, (wasCacheMiss) {
                firstCallWasCacheMiss = wasCacheMiss;
              });
              result2 = AppType.detectWithCallback(context, (wasCacheMiss) {
                secondCallWasCacheMiss = wasCacheMiss;
              });
              return const SizedBox();
            },
          ),
        ),
      );

      expect(result1, equals(result2));
      expect(firstCallWasCacheMiss, isTrue);
      expect(secondCallWasCacheMiss, isFalse);
    });
  });

  group('adaptivePageRouteBuilder', () {
    setUp(() {
      AppType.clearCache();
    });

    testWidgets('should create MaterialPageRoute for MaterialApp context', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final route = adaptivePageRouteBuilder(
                context,
                (context) => const SizedBox(),
              );
              expect(route, isA<MaterialPageRoute>());
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('should create CupertinoPageRoute for CupertinoApp context', (
      tester,
    ) async {
      await tester.pumpWidget(
        CupertinoApp(
          home: Builder(
            builder: (context) {
              final route = adaptivePageRouteBuilder(
                context,
                (context) => const SizedBox(),
              );
              expect(route, isA<CupertinoPageRoute>());
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('should create PageRouteBuilder for WidgetsApp context', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              final route = adaptivePageRouteBuilder(
                context,
                (context) => const SizedBox(),
              );
              expect(route, isA<PageRouteBuilder>());
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });
}
