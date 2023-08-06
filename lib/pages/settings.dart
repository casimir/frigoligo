import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:frigoligo/string_extension.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../providers/logconsole.dart';
import '../providers/settings.dart';
import 'logconsole.dart';
import 'session_details.dart';

final _log = Logger('frigoligo.listing');

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: SettingsList(sections: [
          SettingsSection(
            tiles: [
              SettingsTile.navigation(
                leading: const Icon(Icons.format_paint),
                title: const Text('Appearance'),
                value: Text((settings[Sk.themeMode] as ThemeMode)
                    .name
                    .toCapitalCase()!),
                onPressed: (context) async {
                  AlertDialogAction build(ThemeMode mode) => AlertDialogAction(
                        label: mode.name.toCapitalCase()!,
                        key: mode,
                      );
                  final choice = await showConfirmationDialog(
                    context: context,
                    title: 'Appearance',
                    actions: [
                      build(ThemeMode.system),
                      build(ThemeMode.light),
                      build(ThemeMode.dark),
                    ],
                  );
                  if (choice != null) settings[Sk.themeMode] = choice;
                },
              ),
            ],
          ),
          SettingsSection(tiles: [
            SettingsTile(
              leading: const Icon(Icons.sync),
              title: const Text('Clear cache'),
              onPressed: (context) async {
                final result = await showOkCancelAlertDialog(
                  context: context,
                  title: 'Clear cache',
                  message: 'The local cache will be deleted and fetched again.',
                  okLabel: 'Confirm',
                );
                if (result == OkCancelResult.cancel) return;
                _log.info('user action > cache rebuild');
                settings.remove(Sk.lastRefresh);
                if (context.mounted) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (r) => false);
                }
              },
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onPressed: (context) => PackageInfo.fromPlatform().then((info) {
                showAboutDialog(
                  context: context,
                  // applicationIcon: const FlutterLogo(),
                  applicationVersion: '${info.version}+${info.buildNumber}',
                  applicationLegalese: '© 2023 Casimir Lab',
                );
              }),
            ),
          ]),
          SettingsSection(
            title: const Text('Advanced'),
            tiles: [
              SettingsTile.navigation(
                  leading: const Icon(Icons.key),
                  title: const Text('Session details'),
                  onPressed: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SessionDetailsPage()),
                    );
                  }),
              SettingsTile.navigation(
                  leading: const Icon(Icons.bug_report),
                  title: const Text('Log Console'),
                  onPressed: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                          create: (_) => LogConsoleProvider(),
                          child: const LogConsolePage(),
                        ),
                      ),
                    );
                  }),
            ],
          )
        ]),
      ),
    );
  }
}
