// ignore_for_file: missing_provider_scope

import 'package:flutter/material.dart';
import 'package:frigoligo/ui/core/widgets/adaptive.dart';
import 'package:frigoligo/ui/core/widgets/navigation_split_view.dart';

void main() {
  runApp(DemoApp());
}

class DemoApp extends StatelessWidget {
  DemoApp({super.key});

  final counter = ValueNotifier(3);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: ValueListenableBuilder(
            valueListenable: counter,
            builder: (context, value, child) {
              return Text('NavigationSplitView ($value items)');
            },
          ),
          actions: [
            ValueListenableBuilder(
              valueListenable: counter,
              builder: (context, value, child) {
                return IconButton(
                  onPressed: value > 0 ? () => counter.value-- : null,
                  icon: const Icon(Icons.remove_circle_outline),
                );
              },
            ),
            IconButton(
              onPressed: () {
                counter.value++;
              },
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: WindowQuery(
          child: NavigationSplitView(
            itemCount: counter,
            navigationItemBuilder: (context, index) =>
                ListTile(title: Text('Item $index')),
            contentBuilder: (context, index) => Text('Content $index'),
            contentContainerBuilder: (context, child) {
              return Container(
                color: Colors.white,
                child: Scaffold(
                  backgroundColor: Colors.red.withAlpha(128),
                  appBar: AppBar(leading: const ExpandContentButton()),
                  body: Center(child: child),
                ),
              );
            },
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
