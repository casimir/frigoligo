import 'package:flutter/services.dart';

class SaveService {
  static const MethodChannel _channel =
      MethodChannel('net.casimir-lab.frigoligo/save');

  static void init() {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'hello':
          return 'Hello from the Flutter side!';
        default:
          return MissingPluginException('not implemented');
      }
    });
  }

  static Future<void> hello() async {
    final message = await _channel.invokeMethod<String>('hello');
    print(message);
  }
}
