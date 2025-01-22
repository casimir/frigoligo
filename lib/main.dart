import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l10n_esperanto/l10n_esperanto.dart';
import 'package:logging/logging.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:universal_platform/universal_platform.dart';

import 'app_info.dart';
import 'app_setups.dart';
import 'applinks/handler.dart';
import 'constants.dart';
import 'db/database.dart';
import 'native/appbadge.dart';
import 'native/save.service.dart';
import 'providers/background_sync.dart';
import 'providers/router.dart';
import 'providers/settings.dart';
import 'providers/tools/observer.dart';

Future<void> main() async {
  final log = Logger('main');
  setupLogger(log);
  setupGoogleFonts();

  // after this line using `await` is OK
  WidgetsFlutterBinding.ensureInitialized();

  log.info('starting app');

  LinksHandler.init();

  if (UniversalPlatform.isIOS) {
    await SharedPreferenceAppGroup.setAppGroup(appGroupId);
  }

  await AppBadge.init();
  await AppInfo.init();
  await Settings.init();

  log.info('app version: ${AppInfo.versionVerbose}');
  log.info('db version: ${DB().schemaVersion}');
  log.info('platform:    ${UniversalPlatform.operatingSystem}');
  if (!UniversalPlatform.isWeb) {
    log.info('os version:  ${Platform.operatingSystemVersion}');
  }

  runApp(const ProviderScope(
    observers: [
      if (enableDebugLogs) RiverpodObserver(),
    ],
    child: MyApp(),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  StreamSubscription? _deeplinksSubscription;

  @override
  void initState() {
    super.initState();

    final router = ref.read(routerProvider);

    _deeplinksSubscription =
        LinksHandler.listen(router.configuration, (linkType, uri) {
      if (linkType != Deeplink.invalid) {
        router.go(uri.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // one shot providers
    ref.watch(backgroundSyncProvider);

    final lang = ref.watch(settingsProvider.select((it) => it[Sk.language]));
    final theme = ref.watch(settingsProvider.select((it) => it[Sk.themeMode]));

    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
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
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
    );
  }

  @override
  void dispose() {
    _deeplinksSubscription?.cancel();
    super.dispose();
  }
}

@pragma('vm:entry-point')
Future<void> mainNativeShare() async {
  final log = Logger('mainNativeShare');
  setupLogger(log);

  // after this line using `await` is OK
  WidgetsFlutterBinding.ensureInitialized();

  log.info('starting share extension');

  if (UniversalPlatform.isIOS) {
    await SharedPreferenceAppGroup.setAppGroup(appGroupId);
  }

  await Settings.init();

  SaveService.init();

  SaveService.hello();
}
