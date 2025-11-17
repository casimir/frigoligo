import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../data/services/platform/sharing_service.dart';
import '../../../domain/models/log_entry.dart';
import '../../../domain/repositories.dart';

class LogConsoleViewModel extends ChangeNotifier {
  LogConsoleViewModel({
    required LoggerRepository loggerRepository,
    required SharingService sharingService,
  }) : _loggerRepository = loggerRepository,
       _sharingService = sharingService;

  final LoggerRepository _loggerRepository;
  final SharingService _sharingService;

  Future<List<LogEntry>> getLogs() => _loggerRepository.getLogs();
  Future<List<LogEntry>> getCurrentRunLogs() =>
      _loggerRepository.getCurrentRunLogs();

  Future<int> getLogCount() => _loggerRepository.getLogCount();
  Future<int> getCurrentRunLogCount() =>
      _loggerRepository.getCurrentRunLogCount();

  Future<void> clearLogs() async {
    await _loggerRepository.clear();
    notifyListeners();
  }

  Future<void> shareLogs(bool onlyCurrentRun, Rect sharePositionOrigin) async {
    final timestamp = DateFormat('yyyyMMddTHHmmss').format(DateTime.now());
    final logs = onlyCurrentRun ? await getCurrentRunLogs() : await getLogs();

    await _sharingService.shareAsTextFile(
      'frigoligo_$timestamp.log',
      logs.map((e) => e.format()).join('\n'),
      sharePositionOrigin: sharePositionOrigin,
    );
  }
}
