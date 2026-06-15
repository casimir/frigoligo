import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

import '../buildcontext_extension.dart';
import '../constants.dart';
import '../providers/settings.dart' show Sk, settingsProvider;

class SettingsAdvancedPage extends ConsumerWidget {
  const SettingsAdvancedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.L.settings_itemAdvanced)),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              if (nativeArticleRendererSupported)
                SettingsTile.switchTile(
                  leading: const Icon(Icons.settings_suggest),
                  title: Text(context.L.settings_nativeArticleRenderer),
                  initialValue: settings[Sk.nativeArticleRenderer],
                  onToggle: (value) => ref
                      .read(settingsProvider.notifier)
                      .set(Sk.nativeArticleRenderer, value),
                ),
              SettingsTile.navigation(
                leading: const Icon(Icons.dns),
                title: Text(context.L.settings_itemInternetCheckUrl),
                value: Text(settings[Sk.internetCheckUrl]),
                onPressed: (context) async {
                  final result = await showTextInputDialog(
                    context: context,
                    textFields: [
                      DialogTextField(
                        keyboardType: TextInputType.url,
                        autocorrect: false,
                        initialText: settings[Sk.internetCheckUrl],
                      ),
                    ],
                  );
                  if (result != null) {
                    await ref
                        .read(settingsProvider.notifier)
                        .set(Sk.internetCheckUrl, result.first);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
