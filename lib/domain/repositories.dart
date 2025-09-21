import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../config/logging.dart';

abstract class LoggerRepository {
  Future<int> appendLog(LogRecord record);

  void registerLogHandlers(bool enableDebugLogs) {
    Logger.root.level = enableDebugLogs ? Level.FINE : Level.INFO;
    Logger.root.onRecord.listen((record) {
      appendLog(record);
      debugPrint(formatRecord(record));
    });
  }
}
