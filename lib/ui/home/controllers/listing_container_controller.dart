import '../../../services/remote_sync.dart';

class ListingContainerController {
  const ListingContainerController({required RemoteSyncer remoteSyncer})
    : _remoteSyncer = remoteSyncer;

  final RemoteSyncer _remoteSyncer;

  Future<void> refresh() {
    return _remoteSyncer.synchronize(withFinalRefresh: true);
  }
}
