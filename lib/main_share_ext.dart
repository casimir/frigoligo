import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l10n_esperanto/l10n_esperanto.dart';
import 'package:logging/logging.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:universal_platform/universal_platform.dart';

import 'app_info.dart';
import 'app_setups.dart';
import 'constants.dart';
import 'providers/settings.dart';

final _log = Logger('main-share');

@pragma('vm:entry-point')
Future<void> mainShareExt() async {
  setupLogger(_log);

  // after this line using `await` is OK
  WidgetsFlutterBinding.ensureInitialized();

  _log.info('starting extension');

  await AppInfo.init();
  await Settings.init();

  if (UniversalPlatform.isIOS) {
    await SharedPreferenceAppGroup.setAppGroup(appGroupId);
  }

  await Settings.init();

  // TODO load only what's needed for the save view
  // TODO handle uninitialized session
  runApp(const ProviderScope(child: ShareExt()));
}

class ShareExt extends ConsumerWidget {
  const ShareExt({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(settingsProvider.select((it) => it[Sk.language]));
    final theme = ref.watch(settingsProvider.select((it) => it[Sk.themeMode]));

    return MaterialApp(
      title: 'Frigoligo',
      theme: ThemeData(colorScheme: schemeLight, useMaterial3: true),
      darkTheme: ThemeData(colorScheme: schemeDark, useMaterial3: true),
      themeMode: theme,
      locale: lang.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates +
          const [
            MaterialLocalizationsEo.delegate,
            CupertinoLocalizationsEo.delegate,
          ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const ScreenWidget(),
    );
  }
}

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.check),
        Text(AppInfo.versionVerbose),
      ],
    );
  }
}
