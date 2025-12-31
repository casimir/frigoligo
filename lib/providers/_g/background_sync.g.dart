// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../background_sync.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(backgroundSync)
const backgroundSyncProvider = BackgroundSyncProvider._();

final class BackgroundSyncProvider extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  const BackgroundSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backgroundSyncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backgroundSyncHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return backgroundSync(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$backgroundSyncHash() => r'f5d333764031561ba36382389afa0cc183e77461';
