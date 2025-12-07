import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/config/logging.dart';
import 'package:frigoligo/domain/models/log_entry.dart';
import 'package:frigoligo/ui/logconsole/widgets/log_entry_message.dart';

void main() {
  group('LogEntryMessage', () {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);
    final testTime = DateTime(2000, 1, 2, 3, 4, 5);

    testWidgets('should display at least `time` and `message`', (tester) async {
      final timestamp = LogEntryMessage.formatTimestamp(testTime);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: LogEntryMessage(
            entry: LogEntry(
              time: testTime,
              level: '',
              loggerName: '',
              message: 'Test message',
            ),
            colorScheme: colorScheme,
            alternativeBackground: false,
          ),
        ),
      );

      expect(find.textContaining(timestamp), findsOneWidget);
      expect(find.textContaining('Test message'), findsOneWidget);
    });

    testWidgets('should display the error when it is provided', (tester) async {
      for (final error in ['Test error', null]) {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: LogEntryMessage(
              entry: LogEntry(
                time: testTime,
                level: '',
                loggerName: '',
                message: 'Test message',
                error: error,
              ),
              colorScheme: colorScheme,
              alternativeBackground: false,
            ),
          ),
        );

        expect(
          find.textContaining('Test error'),
          error != null ? findsOneWidget : findsNothing,
        );
      }
    });

    testWidgets('should use different colors for different log levels', (
      tester,
    ) async {
      final levels = ['INFO', 'WARNING', 'SEVERE', 'UNKNOWN'];

      Set<Color?> colors = {};
      for (final level in levels) {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: LogEntryMessage(
              entry: LogEntry(
                time: testTime,
                level: level,
                loggerName: '',
                message: '',
              ),
              colorScheme: colorScheme,
              alternativeBackground: false,
            ),
          ),
        );

        final usedColor = tester.widget<Text>(find.byType(Text)).style?.color;
        colors.add(usedColor);
      }

      expect(colors.length, equals(levels.length));
    });

    testWidgets(
      'should use different colors dependending on the value of alternativeBackground',
      (tester) async {
        Set<Color?> colors = {};
        for (final alternativeBackground in [true, false]) {
          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: LogEntryMessage(
                entry: LogEntry(
                  time: testTime,
                  level: '',
                  loggerName: '',
                  message: '',
                ),
                colorScheme: colorScheme,
                alternativeBackground: alternativeBackground,
              ),
            ),
          );

          final usedColor = tester
              .widget<Container>(find.byType(Container))
              .color;
          colors.add(usedColor);
        }

        expect(colors.length, equals(2));
      },
    );

    testWidgets(
      'should display the starting app message in a different color',
      (tester) async {
        final messages = [startingAppMessage, 'Test message'];

        Set<Color?> colors = {};
        for (final message in messages) {
          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: LogEntryMessage(
                entry: LogEntry(
                  time: testTime,
                  level: '',
                  loggerName: '',
                  message: message,
                ),
                colorScheme: colorScheme,
                alternativeBackground: false,
              ),
            ),
          );

          final usedColor = tester.widget<Text>(find.byType(Text)).style?.color;
          colors.add(usedColor);
        }

        expect(colors.length, equals(messages.length));
      },
    );
  });
}
