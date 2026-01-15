import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/config/dependencies.dart';
import 'package:frigoligo/data/services/local/storage/database/connection/native.dart';
import 'package:frigoligo/data/services/local/storage/database/database.dart';
import 'package:frigoligo/domain/sync/sync_manager.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/core/widgets/remote_sync.dart';
import 'package:frigoligo/ui/home/controllers/listing_container_controller.dart';
import 'package:frigoligo/ui/home/widgets/listing_container.dart';
import 'package:mocktail/mocktail.dart';

class MockListingContainerController extends Mock
    implements ListingContainerController {}

void main() {
  setUpAll(() {
    // Register fallback values for any complex types that might be used
  });

  group('ListingContainer', () {
    late DB db;
    late MockListingContainerController mockController;

    setUp(() {
      db = DB(inMemory());
      setupDependencies(withDB: db);
      SyncManager.init(
        localStorageService: dependencies.get(),
        remoteActionRepository: dependencies.get(),
        serverSessionRepository: dependencies.get(),
        configStoreService: dependencies.get(),
        appBadgeService: dependencies.get(),
      );

      mockController = MockListingContainerController();
      when(() => mockController.refresh()).thenAnswer((_) async {});
    });

    tearDown(() async {
      await dependencies.reset();
      await db.close();
    });

    Widget buildWidget() {
      return ProviderScope(
        child: MaterialApp(
          home: ListingContainer(
            controller: mockController,
            child: const Placeholder(),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      );
    }

    testWidgets('should provides a menu with the main actions', (tester) async {
      await tester.pumpWidget(buildWidget());

      expect(find.byType(PopupMenuButton), findsOneWidget);

      await tester.tap(find.byType(PopupMenuButton));
      await tester.pumpAndSettle();

      expect(find.byType(PopupMenuItem), findsNWidgets(3));

      // Still could not find a good way to test navigation actions. So let's
      // just test the synchronize action for now.
      await tester.tap(
        find.byWidgetPredicate(
          (widget) =>
              widget is PopupMenuItem && widget.value == MenuAction.synchronize,
        ),
      );
      await tester.pumpAndSettle();

      verify(() => mockController.refresh()).called(1);
    });

    testWidgets('should show sync related widget when in full screen', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());

      expect(find.byType(RemoteSyncProgressIndicator), findsOneWidget);
      expect(find.byType(RemoteSyncFAB), findsOneWidget);
    });
  });
}
