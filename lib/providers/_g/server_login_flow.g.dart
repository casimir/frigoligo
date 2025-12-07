// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../server_login_flow.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServerLoginFlow)
const serverLoginFlowProvider = ServerLoginFlowProvider._();

final class ServerLoginFlowProvider
    extends $NotifierProvider<ServerLoginFlow, FlowState> {
  const ServerLoginFlowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverLoginFlowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serverLoginFlowHash();

  @$internal
  @override
  ServerLoginFlow create() => ServerLoginFlow();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlowState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlowState>(value),
    );
  }
}

String _$serverLoginFlowHash() => r'f0b22ea3001568ae6f48dd5312a4a73c5d85b164';

abstract class _$ServerLoginFlow extends $Notifier<FlowState> {
  FlowState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FlowState, FlowState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FlowState, FlowState>,
              FlowState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
