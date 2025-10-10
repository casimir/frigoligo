import 'dart:async';

import 'package:logging/logging.dart';

import 'models/article_data.dart';
import 'models/log_entry.dart';
import 'models/query.dart';

abstract class ArticleRepository {
  Stream<ArticleData?> watchData(int id);
  Stream<String?> watchContent(int id);
}

abstract class LoggerRepository {
  Future<int> appendLog(LogRecord record, {Duration? offset});

  Future<int> getLogCount();
  Future<int> getCurrentRunLogCount();

  Future<List<LogEntry>> getLogs();
  Future<List<LogEntry>> getCurrentRunLogs();

  Future<int> clear();

  StreamSubscription<LogRecord>? _onRecordSubscription;

  void registerLogHandler(bool enableDebugLogs) {
    Logger.root.level = enableDebugLogs ? Level.FINE : Level.INFO;
    _onRecordSubscription = Logger.root.onRecord.listen(appendLog);
  }

  void unregisterLogHandler() {
    _onRecordSubscription?.cancel();
  }
}

abstract class QueryRepository {
  Query get query;
  Stream<Query> get queryStream;
  set query(Query query);

  void dispose() {}

  Stream<List<int>> watchArticleIds();

  Future<int> getResultCount();

  Future<List<String>> listAvailableDomains();
  Future<List<String>> listAvailableTags();
}

abstract class TagRepository {
  Future<List<String>> getAll();
}
