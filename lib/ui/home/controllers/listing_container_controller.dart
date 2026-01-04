import '../../../domain/sync/sync_manager.dart';

class ListingContainerController {
  const ListingContainerController({required SyncManager syncManager})
    : _syncManager = syncManager;

  final SyncManager _syncManager;

  Future<void> refresh() {
    return _syncManager.synchronize(withFinalRefresh: true);
  }
}
