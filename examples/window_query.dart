// ignore_for_file: missing_provider_scope

import 'package:flutter/material.dart';
import 'package:frigoligo/ui/core/widgets/adaptive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WindowQuery(child: Material(child: HomeScreen())),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeClass = WindowQuery.of(context).sizeClass;
    debugPrint('HomeScreen build ($sizeClass)');
    return Center(
      child: Text(
        'Size class: ${sizeClass.name}',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
