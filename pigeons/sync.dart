import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon/sync.g.dart',
    swiftOut: 'ios/Features/Sync/Sync.g.swift',
    dartPackageName: 'frigoligo',
    swiftOptions: SwiftOptions(includeErrorClass: false),
  ),
)
enum SyncIndicatorStatus {
  allGood,
  syncing,
  noInternet,
  serverUnreachable,
  syncError,
  authFailure,
}

class SyncIndicatorState {
  late SyncIndicatorStatus status;
  double? progressValue;
  late int pendingCount;
  int? lastSyncTimestamp;
  String? errorDetail;
}

@HostApi()
abstract class SyncApi {
  void updateSyncState(SyncIndicatorState state);
}
