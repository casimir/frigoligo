import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/main.dart';
import 'package:frigoligo/providers/settings.dart';

void main() {
  group('Smoke Tests', () {
    testWidgets('empty login server', (tester) async {
      unawaited(
        tester.runAsync(() async {
          await Settings.init();
          await tester.pumpWidget(const MyApp());
          expect(find.text('Server'), findsOneWidget);
          await tester.tap(find.byType(ElevatedButton).first);
          await tester.pump();
          expect(find.text('Enter your server address'), findsOneWidget);
        }),
      );
    });
  });
}
