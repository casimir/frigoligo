// coverage:ignore-file
// This just a wrapper around a native capabilities.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:universal_platform/universal_platform.dart';

final _log = Logger('platform.appbadge');

class AppBadgeService {
  const AppBadgeService();

  static const _channel = MethodChannel('net.casimir-lab.frigoligo/appbadge');

  static bool? _isSupported;

  /// Returns whether app badge is supported on the current platform.
  ///
  /// Caches the result after the first call.
  Future<bool> isSupported() async {
    _isSupported ??= switch (currentUniversalPlatform) {
      UniversalPlatformType.Android =>
        _channel
                .invokeMethod<bool>('isSupported')
                .then((value) => value ?? false)
            as bool,
      UniversalPlatformType.IOS || UniversalPlatformType.MacOS => true,
      _ => false,
    };
    return _isSupported!;
  }

  /// Updates the app badge with the given count.
  ///
  /// If [count] is 0, the badge is cleared instead.
  /// No-op if the platform doesn't support app badges.
  Future<void> update(int count) async {
    if (await isSupported() == false) {
      _log.fine('app badge not supported on this platform');
      return;
    }

    if (count == 0) {
      return clear();
    } else {
      _log.info('setting appbadge count to $count');
      return _channel.invokeMethod('update', {'count': count});
    }
  }

  /// Clears the app badge.
  ///
  /// No-op if the platform doesn't support app badges.
  Future<void> clear() async {
    if (await isSupported() == false) {
      _log.fine('app badge not supported on this platform');
      return;
    }
    _log.info('clearing appbadge');
    return AppBadgeService._channel.invokeMethod('remove');
  }

  // DEPRECATED zone

  @Deprecated('support flag caching will become private implementation detail')
  Future<void> initSupportedCache({bool enable = true}) async {
    await isSupported();
  }

  @Deprecated('use [isSupported] instead')
  static bool get isSupportedSync => _isSupported!;
}
