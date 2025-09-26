import 'package:frigoligo/domain/models/log_entry.dart';
import 'package:test/test.dart';

void main() {
  group('LogEntry.format', () {
    final testTime = DateTime(2000, 1, 2, 3, 4, 5);

    test('should format the log entry correctly', () {
      final entry = LogEntry(
        time: testTime,
        level: 'INFO',
        loggerName: 'test.logger',
        message: 'Test message',
      );

      final formatted = entry.format();
      expect(formatted.contains(entry.level), isTrue);
      expect(formatted.contains(entry.loggerName), isTrue);
      expect(formatted.contains(entry.message), isTrue);
    });

    test('should format the log entry correctly with an error', () {
      final entry = LogEntry(
        time: testTime,
        level: 'INFO',
        loggerName: 'test.logger',
        message: 'Test message',
        error: 'Test error',
      );

      final formatted = entry.format();
      expect(formatted.split('\n').length, equals(1));
      expect(formatted.contains(entry.error!), isTrue);
    });

    test('should format the log entry correctly with a stack trace', () {
      final entry = LogEntry(
        time: testTime,
        level: 'INFO',
        loggerName: 'test.logger',
        message: 'Test message',
        stackTrace: 'Test stack trace',
      );

      final formatted = entry.format();
      expect(formatted.split('\n').length, equals(2));
      expect(formatted.split('\n')[1], equals(entry.stackTrace!));
    });
  });
}
