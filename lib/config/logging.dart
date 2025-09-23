import 'package:logging/logging.dart';

export 'package:logging/logging.dart' show LogRecord;

const String startingAppMessage = 'starting app';

String formatRecord(LogRecord record) {
  var line =
      '[${record.time}] ${record.level.name} ${record.loggerName} ${record.message}';
  if (record.error != null) {
    line += ' (${record.error})';
  }
  if (record.stackTrace != null) {
    line += '\n${record.stackTrace}';
  }
  return line.trimRight();
}
