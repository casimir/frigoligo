// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../local_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocalStorage)
const localStorageProvider = LocalStorageProvider._();

final class LocalStorageProvider
    extends $NotifierProvider<LocalStorage, LocalStorageToken> {
  const LocalStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localStorageHash();

  @$internal
  @override
  LocalStorage create() => LocalStorage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalStorageToken value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalStorageToken>(value),
    );
  }
}

String _$localStorageHash() => r'7417f6703ddbcda8e9ab4ba8b82ea5f7055fcb13';

abstract class _$LocalStorage extends $Notifier<LocalStorageToken> {
  LocalStorageToken build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LocalStorageToken, LocalStorageToken>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LocalStorageToken, LocalStorageToken>,
              LocalStorageToken,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
