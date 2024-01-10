import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../buildcontext_extension.dart';
import '../constants.dart';
import '../providers/deeplinks.dart';
import '../providers/settings.dart';
import '../services/remote_sync.dart';
import '../services/wallabag_storage.dart';

final _log = Logger('frigoligo.listing');

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final storage = context.read<WallabagStorage>();
    final syncer = context.read<RemoteSyncer>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.L.settings_title),
      ),
      body: Center(
        child: SettingsList(
          sections: [
            SettingsSection(
              title: Text(context.L.settings_headerPreferences),
              tiles: [
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
                      actions:
                          getOrderedLanguageLabels(context).map(build).toList(),
                    );
                    if (choice != null) settings[Sk.language] = choice;
                  },
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.format_paint),
                  title: Text(context.L.settings_itemAppearance),
                  value:
                      Text(getThemeModeLabel(context, settings[Sk.themeMode])),
                  onPressed: (context) async {
                    AlertDialogAction build(ThemeMode mode) =>
                        AlertDialogAction(
                          label: getThemeModeLabel(context, mode),
                          key: mode,
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
                      if (previous != value) storage.updateAppBadge();
                      return settings[Sk.appBadge] = value;
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
              ],
            ),
            SettingsSection(
              title: Text(context.L.settings_headerGeneral),
              tiles: [
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
                      syncer.synchronize(withFinalRefresh: true);
                      context.go('/');
                    }
                  },
                ),
                SettingsTile(
                  leading: const Icon(Icons.info),
                  title: Text(context.L.settings_itemAbout),
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
              title: Text(context.L.settings_headerAdvanced),
              tiles: [
                SettingsTile.navigation(
                  leading: const Icon(Icons.key),
                  title: Text(context.L.settings_itemSessionDetails),
                  onPressed: (context) => context.push('/session'),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.bug_report),
                  title: Text(context.L.settings_itemLogConsole),
                  onPressed: (context) => context.push('/logs'),
                ),
                SettingsTile(
                  leading: const Icon(Icons.dataset_linked),
                  title: Text(context.L.settings_itemOpenDeeplink),
                  onPressed: (context) async {
                    final urls = await showTextInputDialog(
                        context: context,
                        textFields: [
                          DialogTextField(
                            hintText: context.L.g_url,
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

String getLanguageLabel(BuildContext context, Language lang) {
  return switch (lang) {
    Language.system => context.L.g_system,
    Language.english => context.L.g_langEN,
    Language.french => context.L.g_langFR,
    Language.german => context.L.g_langDE,
  };
}

List<Language> getOrderedLanguageLabels(BuildContext context) {
  final mapping = {
    for (final lang in Language.values)
      if (lang != Language.system) getLanguageLabel(context, lang): lang
  };
  final orderedLabels = mapping.keys.toList()..sort();
  final orderedKeys = orderedLabels.map((e) => mapping[e]!).toList();
  return [Language.system] + orderedKeys;
}

String getThemeModeLabel(BuildContext context, ThemeMode mode) {
  return switch (mode) {
    ThemeMode.system => context.L.g_system,
    ThemeMode.light => context.L.settings_valueThemeLight,
    ThemeMode.dark => context.L.settings_valueThemeDark,
  };
}
