class LogEntry {
  const LogEntry({
    required this.time,
    required this.level,
    required this.loggerName,
    required this.message,
    this.error,
    this.stackTrace,
  });

  final DateTime time;
  final String level;
  final String loggerName;
  final String message;
  final String? error;
  final String? stackTrace;

  String format() {
    var line = '[$time] $level $loggerName $message';
    if (error != null) {
      line += ' ($error)';
    }
    if (stackTrace != null) {
      line += '\n$stackTrace';
    }
    return line.trimRight();
  }
}
