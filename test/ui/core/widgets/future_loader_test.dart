import 'dart:async';

import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frigoligo/ui/core/widgets/future_loader.dart';

void main() {
  group('FutureLoader', () {
    testWidgets(
      'should show a loading indicator until the data is loaded and the builder is called',
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

    testWidgets('should show an error when the future fails', (tester) async {
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

    testWidgets('should use custom loadingBuilder when provided', (
      tester,
    ) async {
      final completer = Completer();

      await tester.pumpWidget(
        MaterialApp(
          home: FutureLoader(
            future: completer.future,
            builder: (context, data) => Text('Loaded: $data'),
            loadingBuilder: (context) => const Text('Custom Loading'),
          ),
        ),
      );

      expect(find.text('Custom Loading'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      completer.complete('success');
      await tester.pumpAndSettle();

      expect(find.text('Custom Loading'), findsNothing);
      expect(find.text('Loaded: success'), findsOneWidget);
    });

    testWidgets('should use custom errorBuilder when provided', (tester) async {
      final completer = Completer();

      await tester.pumpWidget(
        MaterialApp(
          home: FutureLoader(
            future: completer.future,
            builder: (context, data) => Text('Loaded: $data'),
            errorBuilder: (context, error) => const Text('Custom Error'),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Custom Error'), findsNothing);

      completer.completeError('error');
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Custom Error'), findsOneWidget);
      expect(find.byType(ErrorScreen), findsNothing);
    });

    testWidgets(
      'should use default ErrorScreen when errorBuilder is not provided',
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
        expect(find.byType(ErrorScreen), findsNothing);

        completer.completeError('error');
        await tester.pumpAndSettle();

        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(ErrorScreen), findsOneWidget);
      },
    );
  });
}
