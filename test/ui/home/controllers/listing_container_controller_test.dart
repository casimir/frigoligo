import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/domain/managers/sync_manager.dart';
import 'package:frigoligo/ui/home/controllers/listing_container_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockSyncManager extends Mock implements SyncManager {}

void main() {
  group('ListingContainerController', () {
    late MockSyncManager mockSyncManager;
    late ListingContainerController controller;

    setUp(() {
      mockSyncManager = MockSyncManager();
      controller = ListingContainerController(syncManager: mockSyncManager);
    });

    test('refresh', () async {
      when(
        () => mockSyncManager.synchronize(withFinalRefresh: true),
      ).thenAnswer((_) async => {});

      await controller.refresh();

      verify(
        () => mockSyncManager.synchronize(withFinalRefresh: true),
      ).called(1);
    });
  });
}
