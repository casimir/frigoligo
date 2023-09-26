import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:frigoligo/string_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../constants.dart';
import '../providers/deeplinks.dart';
import '../providers/settings.dart';
import '../services/wallabag_storage.dart';

final _log = Logger('frigoligo.listing');

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final storage = context.read<WallabagStorage>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: SettingsList(
          sections: [
            SettingsSection(
              title: const Text('Preferences'),
              tiles: [
                SettingsTile.navigation(
                  leading: const Icon(Icons.format_paint),
                  title: const Text('Appearance'),
                  value: Text((settings[Sk.themeMode] as ThemeMode)
                      .name
                      .toCapitalCase()!),
                  onPressed: (context) async {
                    AlertDialogAction build(ThemeMode mode) =>
                        AlertDialogAction(
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
                if (appBadgeSupported)
                  SettingsTile.switchTile(
                    leading: const Icon(Icons.markunread_mailbox),
                    title: const Text('Show unread badge'),
                    initialValue: settings[Sk.appBadge],
                    onToggle: (value) {
                      final previous = settings[Sk.appBadge];
                      if (previous != value) storage.updateAppBadge();
                      return settings[Sk.appBadge] = value;
                    },
                  ),
                SettingsTile.switchTile(
                  leading: const Icon(Icons.tag),
                  title: const Text('Add a label to saved articles'),
                  initialValue: settings[Sk.tagSaveEnabled],
                  onToggle: (value) => settings[Sk.tagSaveEnabled] = value,
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.tag),
                  title: const Text('Label for saved articles'),
                  value: Text(settings[Sk.tagSaveLabel]),
                  onPressed: (context) async {
                    final result = await showTextInputDialog(
                      context: context,
                      textFields: [
                        DialogTextField(
                          hintText: 'Tag',
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          initialText: settings[Sk.tagSaveLabel],
                        )
                      ],
                    );
                    if (result != null) {
                      settings[Sk.tagSaveLabel] = result.first;
                    }
                  },
                  enabled: settings[Sk.tagSaveEnabled],
                ),
              ],
            ),
            SettingsSection(
              title: const Text('General'),
              tiles: [
                SettingsTile(
                  leading: const Icon(Icons.sync),
                  title: const Text('Clear cache'),
                  onPressed: (context) async {
                    final result = await showOkCancelAlertDialog(
                      context: context,
                      title: 'Clear cache',
                      message:
                          'The local cache will be deleted and fetched again.',
                      okLabel: 'Confirm',
                    );
                    if (result == OkCancelResult.cancel) return;
                    _log.info('user action > cache rebuild');
                    settings.remove(Sk.lastRefresh);
                    if (context.mounted) {
                      storage.fullRefresh();
                      context.go('/');
                    }
                  },
                ),
                SettingsTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  onPressed: (context) =>
                      PackageInfo.fromPlatform().then((info) {
                    showAboutDialog(
                      context: context,
                      // applicationIcon: const FlutterLogo(),
                      applicationVersion: '${info.version}+${info.buildNumber}',
                      applicationLegalese: '© 2023 Casimir Lab',
                    );
                  }),
                ),
              ],
            ),
            SettingsSection(
              title: const Text('Advanced'),
              tiles: [
                SettingsTile.navigation(
                  leading: const Icon(Icons.key),
                  title: const Text('Session details'),
                  onPressed: (context) => context.push('/session'),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.bug_report),
                  title: const Text('Log Console'),
                  onPressed: (context) => context.push('/logs'),
                ),
                SettingsTile(
                  leading: const Icon(Icons.dataset_linked),
                  title: const Text('Open a deeplink'),
                  onPressed: (context) async {
                    final urls = await showTextInputDialog(
                        context: context,
                        textFields: [
                          const DialogTextField(
                            hintText: 'URL',
                            keyboardType: TextInputType.url,
                            autocorrect: false,
                          )
                        ]);
                    if (context.mounted && urls != null) {
                      final uri = Uri.parse(urls.first);
                      context.read<DeeplinksProvider>().receive(uri);
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
