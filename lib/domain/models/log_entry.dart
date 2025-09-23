class LogEntry {
  const LogEntry({
    required this.time,
    required this.level,
    required this.loggerName,
    required this.message,
  });

  final DateTime time;
  final String level;
  final String loggerName;
  final String message;
}
