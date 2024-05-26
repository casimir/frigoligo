import 'dart:io' show Platform;

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../app_info.dart';
import '../buildcontext_extension.dart';
import '../constants.dart';
import '../providers/settings.dart';
import '../services/remote_sync.dart';
import '../widget_keys.dart';

final _log = Logger('settings');

final _settingsSectionSplitter =
    Platform.isAndroid || Platform.isLinux || Platform.isFuchsia
        ? const Text('')
        : null;

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final storage = RemoteSyncer.instance.wallabag!;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.L.settings_title),
      ),
      body: Center(
        child: SettingsList(
          sections: [
            // Preferences
            SettingsSection(tiles: [
              SettingsTile.navigation(
                key: const Key(wkSettingsTheme),
                leading: const Icon(Icons.format_paint),
                title: Text(context.L.settings_itemAppearance),
                value: Text(getThemeModeLabel(context, settings[Sk.themeMode])),
                onPressed: (context) async {
                  AlertDialogAction build(ThemeMode mode) => AlertDialogAction(
                        key: mode,
                        label: getThemeModeLabel(context, mode),
                      );
                  final choice = await showConfirmationDialog(
                    context: context,
                    title: context.L.settings_itemAppearance,
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
                  title: Text(context.L.settings_itemAppBadge),
                  initialValue: settings[Sk.appBadge],
                  onToggle: (value) {
                    final previous = settings[Sk.appBadge];
                    if (previous && !value) {
                      // enabled -> disabled
                      storage.removeAppBadge();
                    } else if (!previous && value) {
                      // disabled -> enabled
                      storage.updateAppBadge();
                    }
                    settings[Sk.appBadge] = value;
                  },
                ),
              SettingsTile.switchTile(
                leading: const Icon(Icons.tag),
                title: Text(context.L.settings_savedArticleTag),
                initialValue: settings[Sk.tagSaveEnabled],
                onToggle: (value) => settings[Sk.tagSaveEnabled] = value,
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.tag),
                title: Text(context.L.settings_savedArticleTagLabel),
                value: Text(settings[Sk.tagSaveLabel]),
                onPressed: (context) async {
                  final result = await showTextInputDialog(
                    context: context,
                    textFields: [
                      DialogTextField(
                        hintText: context.L.g_tag,
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
            ]),
            // Translations
            SettingsSection(title: _settingsSectionSplitter, tiles: [
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: Text(context.L.settings_itemLanguage),
                value: Text(getLanguageLabel(context, settings[Sk.language])),
                onPressed: (context) async {
                  AlertDialogAction build(Language lang) => AlertDialogAction(
                        label: getLanguageLabel(context, lang),
                        key: lang,
                      );
                  final choice = await showConfirmationDialog(
                    context: context,
                    title: context.L.settings_itemLanguage,
                    actions: Language.values.map(build).toList(),
                  );
                  if (choice != null) settings[Sk.language] = choice;
                },
              ),
              SettingsTile(
                leading: const Icon(Icons.handyman),
                trailing: const Icon(Icons.open_in_new),
                title: Text(context.L.settings_helpToTranslate),
                onPressed: (_) => launchUrlString(
                    'https://hosted.weblate.org/projects/frigoligo/'),
              )
            ]),
            // App Info
            SettingsSection(title: _settingsSectionSplitter, tiles: [
              SettingsTile(
                leading: const Icon(Icons.info_outline),
                title: Text(context.L.g_version),
                value: Text(AppInfo.versionVerbose),
                onPressed: (context) async {
                  await Clipboard.setData(
                      ClipboardData(text: AppInfo.versionVerbose));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(context.L.session_copiedToClipboard)));
                  }
                },
              ),
              SettingsTile(
                leading: const Icon(Icons.code),
                trailing: const Icon(Icons.open_in_new),
                title: Text(context.L.g_sourceCode),
                onPressed: (_) =>
                    launchUrlString('https://github.com/casimir/frigoligo'),
              ),
              SettingsTile(
                leading: const Icon(Icons.bug_report),
                trailing: const Icon(Icons.open_in_new),
                title: Text(context.L.settings_bugReportLink),
                onPressed: (_) => launchUrlString(
                    'https://github.com/casimir/frigoligo/issues'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.description),
                title: Text(
                    MaterialLocalizations.of(context).viewLicensesButtonLabel),
                onPressed: (context) => showLicensePage(
                  context: context,
                  applicationLegalese: '© 2023 Casimir Lab',
                ),
              ),
            ]),
            // Advanced
            SettingsSection(title: _settingsSectionSplitter, tiles: [
              SettingsTile.navigation(
                leading: const Icon(Icons.key),
                title: Text(context.L.settings_itemSessionDetails),
                onPressed: (context) => context.push('/session'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.receipt_long),
                title: Text(context.L.settings_itemLogConsole),
                onPressed: (context) => context.push('/logs'),
              ),
              SettingsTile(
                leading: const Icon(Icons.sync),
                title: Text(context.L.settings_itemClearCache),
                onPressed: (context) async {
                  final result = await showOkCancelAlertDialog(
                    context: context,
                    title: context.L.settings_itemClearCache,
                    message: context.L.settings_clearCacheMessage,
                  );
                  if (result == OkCancelResult.cancel) return;
                  _log.info('user action > cache rebuild');
                  settings.remove(Sk.lastRefresh);
                  if (context.mounted) {
                    storage.clearArticles();
                    ref
                        .read(remoteSyncerProvider.notifier)
                        .synchronize(withFinalRefresh: true);
                    context.go('/');
                  }
                },
              ),
            ])
          ],
        ),
      ),
    );
  }
}

String getLanguageLabel(BuildContext context, Language lang) {
  return switch (lang) {
    Language.system => context.L.g_system,
    _ => lang.nativeName,
  };
}

String getThemeModeLabel(BuildContext context, ThemeMode mode) {
  return switch (mode) {
    ThemeMode.system => context.L.g_system,
    ThemeMode.light => context.L.settings_valueThemeLight,
    ThemeMode.dark => context.L.settings_valueThemeDark,
  };
}
