import 'dart:io';
import 'package:emulators/emulators.dart';

Future<void> main() async {
  const List<String> emulatorIds = [
    // https://developer.apple.com/help/app-store-connect/reference/screenshot-specifications
    'iPhone 15 Plus',
    'iPhone 8 Plus',
    // 'iPad Pro (12.9-inch) (6th generation)',
    // 'iPad Pro (12.9-inch) (2th generation)',
  ];
  const configs = [
    {'locale': 'en-GB'},
    {'locale': 'fr-FR'},
  ];

  final emulators = await Emulators.build();
  await emulators.shutdownAll();

  // mitigate a cleanup bug in the emulators package by looping manually
  // https://github.com/tim-smart/dart_emulators/issues/20
  for (final it in emulatorIds) {
    for (final c in configs) {
      await emulators.forEach([it])((device) async {
        final proc = await emulators.drive(
          device,
          'test_driver/main.dart',
          args: ['--no-pub'],
          config: c,
        );
        stderr.addStream(proc.stderr);
        await stdout.addStream(proc.stdout);
      });
    }
  }
}
