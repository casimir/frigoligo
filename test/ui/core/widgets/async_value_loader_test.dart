import 'package:cadanse/components/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frigoligo/ui/core/widgets/async_value_loader.dart';

void main() {
  group('AsyncValueLoader', () {
    testWidgets('should show a loading indicator when AsyncValue is loading', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AsyncValueLoader<String>(
            value: const AsyncValue.loading(),
            builder: (context, data) => Text('Loaded: $data'),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('should call builder with data when AsyncValue has data', (
      tester,
    ) async {
      const testData = 'test data';

      await tester.pumpWidget(
        MaterialApp(
          home: AsyncValueLoader<String>(
            value: const AsyncValue.data(testData),
            builder: (context, data) => Text('Loaded: $data'),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Loaded: $testData'), findsOneWidget);
    });

    testWidgets('should show an error when AsyncValue has one', (tester) async {
      const testError = 'Test error';

      await tester.pumpWidget(
        MaterialApp(
          home: AsyncValueLoader<String>(
            value: AsyncValue.error(testError, StackTrace.current),
            builder: (context, data) => Text('Loaded: $data'),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ErrorScreen), findsOneWidget);
      expect(find.textContaining('Loaded: '), findsNothing);
    });

    testWidgets('should rebuild when AsyncValue changes from loading to data', (
      tester,
    ) async {
      final testProvider =
          NotifierProvider<AsyncStringNotifier, AsyncValue<String>>(
            AsyncStringNotifier.new,
          );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Consumer(
              builder: (context, ref, child) {
                return AsyncValueLoader<String>(
                  value: ref.watch(testProvider),
                  builder: (context, data) => Text('Loaded: $data'),
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.textContaining('Loaded: '), findsNothing);

      final container = ProviderScope.containerOf(
        tester.element(find.byType(MaterialApp)),
      );
      container.read(testProvider.notifier).setData('test');
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Loaded: test'), findsOneWidget);
    });
  });
}

class AsyncStringNotifier extends Notifier<AsyncValue<String>> {
  @override
  AsyncValue<String> build() => const AsyncValue.loading();

  void setData(String data) {
    state = AsyncValue.data(data);
  }
}
