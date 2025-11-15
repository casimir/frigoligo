import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/providers/article.dart';
import 'package:frigoligo/ui/core/widgets/reading_progress_indicator.dart';

class _FakeCurrentReadingProgress extends CurrentReadingProgress {
  _FakeCurrentReadingProgress(this._value);

  final double? _value;

  @override
  double? build() => _value;
}

void main() {
  group('ReadingProgressIndicator', () {
    testWidgets('should display the current reading progress', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentReadingProgressProvider.overrideWith(
              () => _FakeCurrentReadingProgress(0.4),
            ),
          ],
          child: const MaterialApp(home: ReadingProgressIndicator()),
        ),
      );

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('should not display the indicator when the progress is 0', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentReadingProgressProvider.overrideWith(
              () => _FakeCurrentReadingProgress(0),
            ),
          ],
          child: const ReadingProgressIndicator(),
        ),
      );

      expect(find.byType(LinearProgressIndicator), findsNothing);
    });

    testWidgets('should not display the indicator when the progress is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentReadingProgressProvider.overrideWith(
              () => _FakeCurrentReadingProgress(null),
            ),
          ],
          child: const ReadingProgressIndicator(),
        ),
      );

      expect(find.byType(LinearProgressIndicator), findsNothing);
    });

    testWidgets('should be usable as a preferred size widget', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentReadingProgressProvider.overrideWith(
              () => _FakeCurrentReadingProgress(0.4),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(appBar: ReadingProgressIndicator()),
          ),
        ),
      );

      expect(find.byType(ReadingProgressIndicator), findsOneWidget);
    });
  });
}
