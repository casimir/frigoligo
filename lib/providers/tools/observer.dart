// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class RiverpodObserver extends ProviderObserver {
  const RiverpodObserver();

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    print('RIVERPOD.ADD ${context.provider} [$value]');
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    print('RIVERPOD.DISPOSE ${context.provider}');
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    final before = previousValue?.toString().characters.take(200);
    final after = newValue?.toString().characters.take(200);
    print('RIVERPOD.UPDATE ${context.provider} [$before] -> [$after]');
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    print('RIVERPOD.FAIL ${context.provider} $error at $stackTrace');
  }
}
