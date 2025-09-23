import 'package:flutter/foundation.dart';

import '../../domain/models/log_entry.dart';
import '../../domain/repositories.dart';

class LogConsoleViewModel extends ChangeNotifier {
  LogConsoleViewModel({required LoggerRepository loggerRepository})
    : _loggerRepository = loggerRepository;

  final LoggerRepository _loggerRepository;

  Future<List<LogEntry>> getLogs() => _loggerRepository.getLogs();
  Future<List<LogEntry>> getCurrentRunLogs() =>
      _loggerRepository.getCurrentRunLogs();

  Future<int> getLogCount() => _loggerRepository.getLogCount();
  Future<int> getCurrentRunLogCount() =>
      _loggerRepository.getCurrentRunLogCount();

  Future<void> clearLogs() async {
    await _loggerRepository.clearLogs();
    notifyListeners();
  }
}
