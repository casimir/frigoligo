import 'dart:io';
import 'package:emulators/emulators.dart';

Future<void> main() async {
  const List<String> emulatorIds = [
    'iPhone 15',
  ];
  const configs = [
    {'locale': 'en-GB'},
    {'locale': 'fr-FR'},
  ];

  final emulators = await Emulators.build();
  // await emulators.shutdownAll();
  await emulators.forEach(emulatorIds)((device) async {
    for (final c in configs) {
      final proc = await emulators.drive(
        device,
        'test_driver/main.dart',
        args: ['--no-pub'],
        config: c,
      );
      stderr.addStream(proc.stderr);
      await stdout.addStream(proc.stdout);
    }
  });
}
