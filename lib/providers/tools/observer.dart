// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodObserver extends ProviderObserver {
  const RiverpodObserver();

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    print('RIVERPOD.ADD $provider [$value]');
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    print('RIVERPOD.DISPOSE $provider');
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final before = previousValue?.toString().characters.take(200);
    final after = newValue?.toString().characters.take(200);
    print('RIVERPOD.UPDATE $provider [$before] -> [$after]');
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    print('RIVERPOD.FAIL $provider $error at $stackTrace');
  }
}
