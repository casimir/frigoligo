// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file


part of '../settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Settings)
const settingsProvider = SettingsProvider._();

final class SettingsProvider
    extends $NotifierProvider<Settings, Map<Sk, dynamic>> {
  const SettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsHash();

  @$internal
  @override
  Settings create() => Settings();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<Sk, dynamic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<Sk, dynamic>>(value),
    );
  }
}

String _$settingsHash() => r'bffcd852e29e387c7eb7ebf88eb36f98706d64d7';

abstract class _$Settings extends $Notifier<Map<Sk, dynamic>> {
  Map<Sk, dynamic> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<Sk, dynamic>, Map<Sk, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<Sk, dynamic>, Map<Sk, dynamic>>,
              Map<Sk, dynamic>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
