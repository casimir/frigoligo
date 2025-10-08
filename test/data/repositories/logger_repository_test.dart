import 'package:test/test.dart';
import 'package:frigoligo/data/repositories/logger_repository.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/data/services/local/storage/logging_storage_service.dart';
import 'package:frigoligo/domain/repositories.dart';
import 'package:logging/logging.dart';

void main() {
  group('LoggerRepositoryImpl', () {
    const startingAppMessage = 'BEGIN';
    const maxLogCount = 10;

    late DB db;
    late LoggerRepository loggerRepository;

    setUp(() {
      db = DB(inMemory());
      loggerRepository = LoggerRepositoryImpl(
        loggingStorageService: LoggingStorageService(db: db),
        startingAppMessage: startingAppMessage,
        maxLogCount: maxLogCount,
      )..registerLogHandler(false);
    });

    tearDown(() async {
      loggerRepository.unregisterLogHandler();
      await db.close();
    });

    test('should append log sent by the loggers', () async {
      expect(await loggerRepository.getLogCount(), equals(0));

      Logger('test').info('message');

      expect(await loggerRepository.getLogCount(), equals(1));

      final logs = await loggerRepository.getLogs();
      expect(logs.length, equals(1));
      expect(logs[0].loggerName, equals('test'));
      expect(logs[0].message, equals('message'));
    });

    test('should be able to isolate the current run logs', () async {
      int logOffset = 1;
      Future<void> appendLogWithOffset(String message) async {
        await loggerRepository.appendLog(
          LogRecord(Level.INFO, message, ''),
          offset: Duration(seconds: logOffset++),
        );
      }

      await appendLogWithOffset('message pre');

      expect(await loggerRepository.getLogCount(), equals(1));
      expect(await loggerRepository.getCurrentRunLogCount(), equals(0));

      await appendLogWithOffset(startingAppMessage);
      await appendLogWithOffset('message post');

      expect(await loggerRepository.getCurrentRunLogCount(), equals(2));

      final currentRunLogs = await loggerRepository.getCurrentRunLogs();
      expect(currentRunLogs.length, equals(2));
      expect(currentRunLogs[1].message, equals('message post'));
    });

    test(
      'should not be able to isolate the current run logs when no starting message is found',
      () async {
        Logger.root.info('message pre');

        expect(await loggerRepository.getLogCount(), equals(1));
        expect(await loggerRepository.getCurrentRunLogCount(), equals(0));

        Logger.root.info('message post');

        expect(await loggerRepository.getCurrentRunLogCount(), equals(0));
        expect(await loggerRepository.getCurrentRunLogs(), isEmpty);
      },
    );

    test('should delete everything when clear() is called', () async {
      Logger.root.info('message 1');
      Logger.root.info('message 2');
      Logger.root.info('message 3');

      expect(await loggerRepository.getLogCount(), equals(3));

      await loggerRepository.clear();

      expect(await loggerRepository.getLogCount(), equals(0));
    });

    test('should truncate logs when max log count is reached', () async {
      int logOffset = maxLogCount + 1;
      Future<void> appendLogWithOffset(String message) async {
        await loggerRepository.appendLog(
          LogRecord(Level.INFO, message, ''),
          offset: Duration(seconds: -(logOffset--)),
        );
      }

      for (var i = 0; i < maxLogCount - 1; i++) {
        await appendLogWithOffset('message $i');
      }
      await appendLogWithOffset(startingAppMessage);

      expect(await loggerRepository.getLogCount(), equals(maxLogCount));

      // direct call because we need to wait for the background logic to finish
      await loggerRepository.appendLog(LogRecord(Level.INFO, 'message+1', ''));

      expect(await loggerRepository.getLogCount(), equals(2));
    });

    test(
      'should not truncate logs when max log count is reached but no starting message is found',
      () async {
        for (var i = 0; i < maxLogCount; i++) {
          Logger.root.info('message $i');
        }

        expect(await loggerRepository.getLogCount(), equals(maxLogCount));

        Logger.root.info('message+1');

        expect(await loggerRepository.getLogCount(), equals(maxLogCount + 1));
      },
    );
  });
}
