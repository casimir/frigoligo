import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/ui/core/widgets/adaptive.dart';
import 'package:frigoligo/ui/core/widgets/navigation_split_view.dart';

const navigationLabel = 'Navigation';
const contentLabel = 'Content';

class SimpleApp extends StatelessWidget {
  const SimpleApp({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Material(child: WindowQuery(child: child)));
  }
}

class SimpleNavigationSplitView extends StatelessWidget {
  const SimpleNavigationSplitView({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationSplitView(
      itemCount: ValueNotifier(1),
      navigationItemBuilder: (context, index) => const Text(navigationLabel),
      contentBuilder: (context, index) => const Text(contentLabel),
    );
  }
}

void expectSimpleSideBySideLayout(WidgetTester tester) {
  expect(find.text(navigationLabel), findsOneWidget);
  expect(find.text(contentLabel), findsOneWidget);
}

void expectSimpleNavigationFullLayout(WidgetTester tester) {
  expect(find.text(navigationLabel), findsOneWidget);
  expect(find.text(contentLabel), findsNothing);
}

void expectSimpleContentFullLayout(WidgetTester tester) {
  expect(find.text(navigationLabel), findsNothing);
  expect(find.text(contentLabel), findsOneWidget);
}
