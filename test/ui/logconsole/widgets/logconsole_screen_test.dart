import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/domain/models/log_entry.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/logconsole/viewmodels/logconsole_viewmodel.dart';
import 'package:frigoligo/ui/logconsole/widgets/logconsole_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockLogConsoleViewModel extends Mock implements LogConsoleViewModel {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

class FakeRect extends Fake implements Rect {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRect());
    registerFallbackValue(FakeRoute());
  });

  group('LogConsoleScreen', () {
    late MockLogConsoleViewModel mockViewModel;

    setUp(() {
      mockViewModel = MockLogConsoleViewModel();
    });

    testWidgets('should display the log entries', (tester) async {
      when(
        () => mockViewModel.getCurrentRunLogs(),
      ).thenAnswer((_) async => _generateNLogEntries(3));

      await tester.pumpWidget(
        MaterialApp(
          home: LogConsoleScreen(viewModel: mockViewModel),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Test message 1.'), findsOneWidget);
      expect(find.textContaining('Test message 2.'), findsOneWidget);
      expect(find.textContaining('Test message 3.'), findsOneWidget);
    });

    testWidgets('should scroll to the bottom when the log entries are loaded', (
      tester,
    ) async {
      when(
        () => mockViewModel.getCurrentRunLogs(),
      ).thenAnswer((_) async => _generateNLogEntries(30));

      await tester.pumpWidget(
        MaterialApp(
          home: LogConsoleScreen(viewModel: mockViewModel),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Test message 1.'), findsNothing);
      expect(find.textContaining('Test message 5.'), findsOneWidget);
      expect(find.textContaining('Test message 25.'), findsOneWidget);
    });

    testWidgets(
      'should export current run logs as file when the export button is pressed',
      (tester) async {
        const logCount = 3;

        when(
          () => mockViewModel.getLogCount(),
        ).thenAnswer((_) async => logCount * 2);
        when(
          () => mockViewModel.getCurrentRunLogCount(),
        ).thenAnswer((_) async => logCount);
        when(
          () => mockViewModel.getCurrentRunLogs(),
        ).thenAnswer((_) async => _generateNLogEntries(logCount));
        when(
          () => mockViewModel.shareLogs(any(), any()),
        ).thenAnswer((_) async {});

        await tester.pumpWidget(
          MaterialApp(
            home: LogConsoleScreen(viewModel: mockViewModel),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        );
        await tester.pumpAndSettle();

        final BuildContext context = tester.element(
          find.byType(LogConsoleScreen),
        );
        final l = AppLocalizations.of(context)!;

        await tester.tap(find.byTooltip(l.logconsole_export_title));
        await tester.pumpAndSettle();
        await tester.tap(
          find.text(l.logconsole_export_current_session(logCount)),
        );
        await tester.pumpAndSettle();

        final captured =
            verify(() => mockViewModel.shareLogs(captureAny(), any())).captured;

        final bool onlyCurrentRun = captured[0];
        expect(onlyCurrentRun, true);
      },
      skip: true, // adaptive_dialog is not working as expected in tests
    );

    testWidgets(
      'should export all logs as file when the export button is pressed',
      (tester) async {
        const logCount = 3;

        when(
          () => mockViewModel.getLogCount(),
        ).thenAnswer((_) async => logCount * 2);
        when(
          () => mockViewModel.getCurrentRunLogCount(),
        ).thenAnswer((_) async => logCount);
        when(
          () => mockViewModel.getCurrentRunLogs(),
        ).thenAnswer((_) async => _generateNLogEntries(logCount));
        when(
          () => mockViewModel.shareLogs(any(), any()),
        ).thenAnswer((_) async {});

        await tester.pumpWidget(
          MaterialApp(
            home: LogConsoleScreen(viewModel: mockViewModel),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        );
        await tester.pumpAndSettle();

        final BuildContext context = tester.element(
          find.byType(LogConsoleScreen),
        );
        final l = AppLocalizations.of(context)!;

        await tester.tap(find.byTooltip(l.logconsole_export_title));
        await tester.pumpAndSettle();
        await tester.tap(find.text(l.logconsole_export_all_logs(logCount * 2)));
        await tester.pumpAndSettle();

        final captured =
            verify(() => mockViewModel.shareLogs(captureAny(), any())).captured;

        final bool onlyCurrentRun = captured[0];
        expect(onlyCurrentRun, false);
      },
      skip: true, // adaptive_dialog is not working as expected in tests
    );

    testWidgets('should not export logs when the user cancels the dialog', (
      tester,
    ) async {
      const logCount = 3;

      when(
        () => mockViewModel.getLogCount(),
      ).thenAnswer((_) async => logCount * 2);
      when(
        () => mockViewModel.getCurrentRunLogCount(),
      ).thenAnswer((_) async => logCount);
      when(
        () => mockViewModel.getCurrentRunLogs(),
      ).thenAnswer((_) async => _generateNLogEntries(logCount));
      when(
        () => mockViewModel.shareLogs(any(), any()),
      ).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          home: LogConsoleScreen(viewModel: mockViewModel),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      );
      await tester.pumpAndSettle();

      final BuildContext context = tester.element(
        find.byType(LogConsoleScreen),
      );
      final l = AppLocalizations.of(context)!;

      await tester.tap(find.byTooltip(l.logconsole_export_title));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l.logconsole_export_all_logs(logCount * 2)));
      await tester.pumpAndSettle();

      verifyNever(() => mockViewModel.shareLogs(any(), any()));
    });

    testWidgets('should trigger a navigation pop when logs are cleared', (
      tester,
    ) async {
      final mockNavigationObserver = MockNavigatorObserver();

      when(() => mockViewModel.getCurrentRunLogs()).thenAnswer((_) async => []);
      when(() => mockViewModel.clearLogs()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          home: LogConsoleScreen(viewModel: mockViewModel),
          navigatorObservers: [mockNavigationObserver],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      );
      await tester.pumpAndSettle();

      final BuildContext context = tester.element(
        find.byType(LogConsoleScreen),
      );
      final tooltip = AppLocalizations.of(context)!.logconsole_clear_logs;

      await tester.tap(find.byTooltip(tooltip));
      await tester.pumpAndSettle();

      verify(() => mockViewModel.clearLogs()).called(1);
      verify(() => mockNavigationObserver.didPop(any(), any())).called(1);
    });
  });
}

List<LogEntry> _generateNLogEntries(int n) {
  final now = DateTime.now();
  return List.generate(
    n,
    (index) => LogEntry(
      time: now.subtract(Duration(seconds: n - index)),
      level: 'INFO',
      loggerName: 'test.logger',
      message: 'Test message ${index + 1}.',
    ),
  );
}
