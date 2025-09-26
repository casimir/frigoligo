import 'dart:async';

import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frigoligo/ui/core/widgets/future_loader.dart';

void main() {
  group('FutureLoader', () {
    testWidgets(
      'should show loading indicator until the data is loaded and the builder is called',
      (tester) async {
        final completer = Completer();

        await tester.pumpWidget(
          MaterialApp(
            home: FutureLoader(
              future: completer.future,
              builder: (context, data) => Text('Loaded: $data'),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Loaded: success'), findsNothing);

        completer.complete('success');
        await tester.pumpAndSettle();

        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text('Loaded: success'), findsOneWidget);
      },
    );

    testWidgets('should show error when the future fails', (tester) async {
      final completer = Completer();

      await tester.pumpWidget(
        MaterialApp(
          home: FutureLoader(
            future: completer.future,
            builder: (context, data) => Text('Loaded: $data'),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ErrorScreen), findsNothing);

      completer.completeError('error');
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ErrorScreen), findsOneWidget);
    });
  });
}
