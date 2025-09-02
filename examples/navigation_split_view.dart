// ignore_for_file: missing_provider_scope

import 'package:flutter/material.dart';
import 'package:frigoligo/ui/core/widgets/navigation_split_view.dart';

void main() {
  runApp(
    MaterialApp(
      home: Material(
        child: NavigationSplitView(
          itemCount: 3,
          navigationItemBuilder:
              (context, index) => ListTile(title: Text('Item $index')),
          navigationContainerBuilder:
              (context, selectedIndex, child) => Container(child: child),
          contentBuilder:
              (context, index) => Container(
                color: Colors.white,
                child: Scaffold(
                  backgroundColor: Colors.red.withAlpha(128),
                  appBar: AppBar(leading: const ExpandContentButton()),
                  body: Center(child: Text('Content $index')),
                ),
              ),
        ),
      ),
    ),
  );
}
