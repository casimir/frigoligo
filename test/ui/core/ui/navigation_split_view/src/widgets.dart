import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/ui/core/ui/navigation_split_view/navigation_split_view.dart';

const navigationLabel = 'Navigation';
const contentLabel = 'Content';

class SimpleApp extends StatelessWidget {
  const SimpleApp({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(child: MaterialApp(home: child));
  }
}

class SimpleNavigationSplitView extends StatelessWidget {
  const SimpleNavigationSplitView({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationSplitView(
      itemCount: 1,
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

void main() {
  // TODO remove when the dev is over
  runApp(
    SimpleApp(
      child: NavigationSplitView(
        itemCount: 3,
        navigationItemBuilder:
            (context, index) => ListTile(title: Text('Item $index')),
        navigationContainerBuilder:
            (context, selectedIndex, child) =>
                Container(color: Colors.green.withAlpha(128), child: child),
        contentBuilder:
            (context, index) => Scaffold(
              backgroundColor: Colors.red.withAlpha(128),
              appBar: AppBar(leading: const ExpandContentButton()),
              body: Center(child: Text('Content $index')),
            ),
      ),
    ),
  );
}
