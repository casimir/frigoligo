// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionHash() => r'45d08a6c9e3e26738cdcc4fbd037fde33ec00951';

/// See also [Session].
@ProviderFor(Session)
final sessionProvider =
    AutoDisposeAsyncNotifierProvider<Session, ServerSession?>.internal(
  Session.new,
  name: r'sessionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sessionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Session = AutoDisposeAsyncNotifier<ServerSession?>;
String _$clientHash() => r'fb1c67b2ffc7d32f4c54db3eca42bb4afee9ed6b';

/// See also [Client].
@ProviderFor(Client)
final clientProvider =
    AutoDisposeAsyncNotifierProvider<Client, WallabagClient?>.internal(
  Client.new,
  name: r'clientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$clientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Client = AutoDisposeAsyncNotifier<WallabagClient?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
