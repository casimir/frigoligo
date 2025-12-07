// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Session)
const sessionProvider = SessionProvider._();

final class SessionProvider
    extends $AsyncNotifierProvider<Session, ServerSession?> {
  const SessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionHash();

  @$internal
  @override
  Session create() => Session();
}

String _$sessionHash() => r'45d08a6c9e3e26738cdcc4fbd037fde33ec00951';

abstract class _$Session extends $AsyncNotifier<ServerSession?> {
  FutureOr<ServerSession?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ServerSession?>, ServerSession?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ServerSession?>, ServerSession?>,
              AsyncValue<ServerSession?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(Client)
const clientProvider = ClientProvider._();

final class ClientProvider extends $AsyncNotifierProvider<Client, ApiClient?> {
  const ClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientHash();

  @$internal
  @override
  Client create() => Client();
}

String _$clientHash() => r'e3ed61b057e0cadc7aa4569fbcf1b59a28a7599e';

abstract class _$Client extends $AsyncNotifier<ApiClient?> {
  FutureOr<ApiClient?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ApiClient?>, ApiClient?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ApiClient?>, ApiClient?>,
              AsyncValue<ApiClient?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
