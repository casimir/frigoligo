// coverage:ignore-file
import '../config/dependencies.dart';
import '../pigeon/settings.g.dart';

class LogConsoleBridge implements LogConsoleFlutterApi {
  LogConsoleBridge() {
    LogConsoleFlutterApi.setUp(this);
  }

  @override
  Future<List<NativeLogEntry>> getLogs(bool onlyCurrentRun) async {
    final loggerRepo = dependencies.get<LoggerRepository>();
    final entries = onlyCurrentRun
        ? await loggerRepo.getCurrentRunLogs()
        : await loggerRepo.getLogs();
    return entries
        .map(
          (e) => NativeLogEntry(
            time: e.time.toIso8601String(),
            level: e.level,
            loggerName: e.loggerName,
            message: e.message,
            error: e.error,
          ),
        )
        .toList();
  }

  @override
  Future<void> clearLogs() => dependencies.get<LoggerRepository>().clear();
}
