import 'dart:async';

import 'package:flutter/services.dart';
import 'package:universal_platform/universal_platform.dart';

class AppBadge {
  static const MethodChannel _channel =
      MethodChannel('net.casimir-lab.frigoligo/appbadge');

  static Future<void> update(int count) =>
      _channel.invokeMethod('update', {'count': count});

  static Future<void> remove() => _channel.invokeMethod('remove');

  static Future<bool> isSupported() async => switch (currentUniversalPlatform) {
        UniversalPlatformType.Android => _channel
            .invokeMethod<bool>('isSupported')
            .then((value) => value ?? false),
        UniversalPlatformType.IOS || UniversalPlatformType.MacOS => true,
        _ => false,
      };

  // Sync version of isSupported

  static late bool _isSupported;

  static Future<void> init() async {
    _isSupported = await isSupported();
  }

  static bool get isSupportedSync => _isSupported;
}
