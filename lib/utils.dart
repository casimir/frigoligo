import 'package:logging/logging.dart';

String loglineFromRecord(LogRecord record) {
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
