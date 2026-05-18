import Flutter

@MainActor
class SyncViewModel: NSObject, ObservableObject, SyncApi {
  @Published var syncState: SyncIndicatorState = SyncIndicatorState(
    status: .allGood, progressValue: nil, pendingCount: 0,
    lastSyncTimestamp: nil, errorDetail: nil)

  init(binaryMessenger: FlutterBinaryMessenger) {
    super.init()
    SyncApiSetup.setUp(binaryMessenger: binaryMessenger, api: self)
  }

  func updateSyncState(state: SyncIndicatorState) throws {
    syncState = state
  }
}
