import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/data/repositories/logger_repository.dart';
import 'package:frigoligo/data/services/platform/sharing/sharing_service.dart';
import 'package:frigoligo/domain/repositories.dart';
import 'package:frigoligo/ui/logconsole/viewmodels/logconsole_viewmodel.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/services/inmemory_logging_storage_service.dart';

class MockSharingService extends Mock implements SharingService {}

void main() {
  group('LogConsoleViewModel', () {
    const startingAppMessage = 'BEGIN';
    const logMessages = ['pre begin', startingAppMessage, 'post begin'];

    late LogConsoleViewModel viewModel;
    late LoggerRepository loggerRepository;
    late MockSharingService mockSharingService;

    setUp(() {
      loggerRepository = LoggerRepositoryImpl(
        loggingStorageService: InMemoryLoggingStorageService(),
        startingAppMessage: startingAppMessage,
        maxLogCount: 10,
      )..registerLogHandler(false);

      for (var message in logMessages) {
        Logger.root.info(message);
      }

      mockSharingService = MockSharingService();
      viewModel = LogConsoleViewModel(
        loggerRepository: loggerRepository,
        sharingService: mockSharingService,
      );
    });

    tearDown(() {
      Logger.root.clearListeners();
    });

    test('get*LogCount methods should return the correct counts', () async {
      expect(await viewModel.getLogCount(), equals(3));
      expect(await viewModel.getCurrentRunLogCount(), equals(2));
    });

    test('clearLogs() should clear logs and notify listeners', () async {
      int notifyListenersCount = 0;
      viewModel.addListener(() {
        notifyListenersCount++;
      });

      await viewModel.clearLogs();

      expect(await viewModel.getLogCount(), equals(0));
      expect(notifyListenersCount, equals(1));
    });

    group('shareLogs(...)', () {
      test(
        'should share current run logs when onlyCurrentRun is true',
        () async {
          when(
            () => mockSharingService.shareAsTextFile(
              any(),
              any(),
              sharePositionOrigin: any(named: 'sharePositionOrigin'),
            ),
          ).thenAnswer((_) async {});

          await viewModel.shareLogs(true, Rect.zero);

          final captured =
              verify(
                () => mockSharingService.shareAsTextFile(
                  captureAny(),
                  captureAny(),
                  sharePositionOrigin: any(named: 'sharePositionOrigin'),
                ),
              ).captured;

          final content = captured[1] as String;
          for (final line in content.split('\n').indexed) {
            // skip the first message to begin with the starting app message
            expect(line.$2.endsWith(logMessages[1 + line.$1]), isTrue);
          }
        },
      );

      test('should share all logs when onlyCurrentRun is false', () async {
        when(
          () => mockSharingService.shareAsTextFile(
            any(),
            any(),
            sharePositionOrigin: any(named: 'sharePositionOrigin'),
          ),
        ).thenAnswer((_) async {});

        await viewModel.shareLogs(false, Rect.zero);

        final captured =
            verify(
              () => mockSharingService.shareAsTextFile(
                captureAny(),
                captureAny(),
                sharePositionOrigin: any(named: 'sharePositionOrigin'),
              ),
            ).captured;

        final content = captured[1] as String;
        for (final line in content.split('\n').indexed) {
          expect(line.$2.endsWith(logMessages[line.$1]), isTrue);
        }
      });
    });
  });
}
