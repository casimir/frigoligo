import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l10n_esperanto/l10n_esperanto.dart';
import 'package:language_info_plus/language_info_plus.dart';
import 'package:logging/logging.dart';
import 'package:universal_platform/universal_platform.dart';

import 'app_info.dart';
import 'app_setups.dart';
import 'applinks/handler.dart';
import 'config/dependencies.dart';
import 'config/logging.dart';
import 'constants.dart';
import 'data/services/local/storage/config_store_service.dart';
import 'data/services/local/storage/storage_service.dart';
import 'native/appbadge.dart';
import 'native/save.service.dart';
import 'providers/background_sync.dart';
import 'providers/router.dart';
import 'providers/settings.dart';
import 'providers/tools/observer.dart';
import 'src/generated/i18n/app_localizations.dart';
import 'ui/article/widgets/article_content.dart';

Future<void> main() async {
  setupDependencies();

  final log = Logger('main');
  setupLogger(log);
  setupGoogleFonts();

  // after this line using `await` is OK
  WidgetsFlutterBinding.ensureInitialized();

  log.info(startingAppMessage);

  await initializeLanguage();

  await dependencies.get<ConfigStoreService>().initialize();

  LinksHandler.init();

  await AppBadge.init();
  await AppInfo.init();
  if (!UniversalPlatform.isWeb) {
    await ArticleContentRenderer.preload();
  }
  await Settings.init();

  log.info('app version: ${AppInfo.versionVerbose}');
  log.info('db version:  ${dependencies.get<LocalStorageService>().dbVersion}');
  log.info('platform:    ${UniversalPlatform.operatingSystem}');
  if (!UniversalPlatform.isWeb) {
    log.info('os version:  ${Platform.operatingSystemVersion}');
  }

  runApp(
    const ProviderScope(
      observers: [if (enableDebugLogs) RiverpodObserver()],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  StreamSubscription? _deeplinksSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final router = ref.read(routerProvider);

    _deeplinksSubscription = LinksHandler.listen(router.configuration, (
      linkType,
      uri,
    ) {
      if (linkType != Deeplink.invalid) {
        router.go(uri.toString());
      }
    });
  }

  @override
  void dispose() {
    _deeplinksSubscription?.cancel();

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
      darkTheme: ThemeData(
        colorScheme: schemeDark,
        useMaterial3: true,
        cupertinoOverrideTheme: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(),
        ),
      ),
      themeMode: theme,
      locale: lang.locale,
      localizationsDelegates:
          AppLocalizations.localizationsDelegates +
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      dependencies.get<ConfigStoreService>().reload();
    }
  }
}

@pragma('vm:entry-point')
Future<void> mainNativeShare() async {
  setupDependencies();

  final log = Logger('mainNativeShare');
  setupLogger(log);

  // after this line using `await` is OK
  WidgetsFlutterBinding.ensureInitialized();

  log.info('starting share extension');

  await dependencies.get<ConfigStoreService>().initialize();

  await AppBadge.init(enable: false);
  await AppInfo.init();
  await Settings.init();

  SaveService.setup();
}
