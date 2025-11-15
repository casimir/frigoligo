import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/services/remote_sync.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/core/widgets/remote_sync.dart';

class _FakeRemoteSyncer extends RemoteSyncer {
  _FakeRemoteSyncer(this._state);

  final SyncState _state;

  @override
  SyncState build() => _state;
}

void main() {
  Widget buildWidget(SyncState state) {
    return ProviderScope(
      overrides: [
        // ignore: scoped_providers_should_specify_dependencies
        remoteSyncerProvider.overrideWith(() => _FakeRemoteSyncer(state)),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: Center(child: RemoteSyncProgressIndicator()),
          floatingActionButton: RemoteSyncFAB(),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
      ),
    );
  }

  group('RemoteSyncFAB', () {
    testWidgets(
      'should not display the button when there are no pending actions',
      (tester) async {
        const state = SyncState(
          isWorking: false,
          progressValue: null,
          lastError: null,
          pendingCount: 0,
        );

        await tester.pumpWidget(buildWidget(state));

        expect(find.byType(FloatingActionButton), findsNothing);
      },
    );

    testWidgets('should display the button when there are pending actions', (
      tester,
    ) async {
      const state = SyncState(
        isWorking: false,
        progressValue: null,
        lastError: null,
        pendingCount: 1,
      );

      await tester.pumpWidget(buildWidget(state));

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('should display the button when the sync is working', (
      tester,
    ) async {
      const state = SyncState(
        isWorking: true,
        progressValue: null,
        lastError: null,
        pendingCount: 1,
      );

      await tester.pumpWidget(buildWidget(state));

      expect(find.byType(FloatingActionButton), findsNothing);
    });
  });

  group('RemoteSyncProgressIndicator', () {
    testWidgets(
      'should display the progress indicator when the sync is working',
      (tester) async {
        const state = SyncState(
          isWorking: true,
          progressValue: 0.5,
          lastError: null,
          pendingCount: 0,
        );

        await tester.pumpWidget(buildWidget(state));

        expect(find.bySubtype<ProgressIndicator>(), findsOneWidget);
      },
    );

    testWidgets('should display a message when there is an error', (
      tester,
    ) async {
      final error = Exception('test error');
      final state = SyncState(
        isWorking: false,
        progressValue: null,
        lastError: error,
        pendingCount: 0,
      );

      await tester.pumpWidget(buildWidget(state));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(error.toString()), findsOneWidget);
    });

    testWidgets('should be usable as a preferred size widget', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(appBar: RemoteSyncProgressIndicator()),
          ),
        ),
      );

      expect(find.byType(RemoteSyncProgressIndicator), findsOneWidget);
    });
  });
}
