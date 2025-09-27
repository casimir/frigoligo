// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file


part of '../client.dart';

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
String _$clientHash() => r'e3ed61b057e0cadc7aa4569fbcf1b59a28a7599e';

/// See also [Client].
@ProviderFor(Client)
final clientProvider =
    AutoDisposeAsyncNotifierProvider<Client, ApiClient?>.internal(
      Client.new,
      name: r'clientProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product') ? null : _$clientHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Client = AutoDisposeAsyncNotifier<ApiClient?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
