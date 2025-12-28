// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../remote_sync.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RemoteSyncer)
const remoteSyncerProvider = RemoteSyncerProvider._();

final class RemoteSyncerProvider
    extends $NotifierProvider<RemoteSyncer, SyncState> {
  const RemoteSyncerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteSyncerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteSyncerHash();

  @$internal
  @override
  RemoteSyncer create() => RemoteSyncer();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncState>(value),
    );
  }
}

String _$remoteSyncerHash() => r'e1abb866633d2102d601e639e1b1f84e95fb6562';

abstract class _$RemoteSyncer extends $Notifier<SyncState> {
  SyncState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SyncState, SyncState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SyncState, SyncState>,
              SyncState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
