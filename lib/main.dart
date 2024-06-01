import 'dart:async';
import 'dart:io' show Platform;

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';

import 'app_info.dart';
import 'applinks/handler.dart';
import 'constants.dart';
import 'models/db.dart';
import 'providers/router.dart';
import 'providers/settings.dart';
import 'providers/tools/observer.dart';
import 'services/remote_sync.dart';
import 'wallabag/wallabag.dart';

const enableDebugLogs = false;
final _log = Logger('frigoligo');

// TODO factorize init steps
Future<void> main() async {
  Logger.root.level = enableDebugLogs ? Level.FINE : Level.INFO;
  Logger.root.onRecord.listen((record) {
    DB.appendLog(record);
    var line =
        '[${record.time}] ${record.level.name} ${record.loggerName} ${record.message}';
    if (record.error != null) {
      line += ' (${record.error})';
    }
    debugPrint(line);
  });
  FlutterError.onError = (errorDetails) {
    final repr = errorDetails.exceptionAsString();
    _log.severe('uncaught error', repr, errorDetails.stack);
    FlutterError.presentError(errorDetails);
  };

  _log.info('starting app');

  LinksHandler.init();

  // prevent fetching fonts from the internet, only loads the ones in the assets
  GoogleFonts.config.allowRuntimeFetching = false;
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // after this line using `await` is OK
  WidgetsFlutterBinding.ensureInitialized();

  await AppInfo.init();
  await DB.init(kDebugMode);
  await WallabagInstance.init();
  await SettingsValues.init();

  _log.info('app version: ${AppInfo.versionVerbose}');
  _log.info('platform:    ${Platform.operatingSystem}');
  _log.info('os version:  ${Platform.operatingSystemVersion}');

  if (periodicSyncSupported) {
    _log.info('starting periodic sync');
    NeatPeriodicTaskScheduler(
      interval: periodicSyncInterval,
      name: 'background-sync',
      timeout: periodicSyncTimeout,
      task: () async =>
          RemoteSyncer.instance.synchronize(withFinalRefresh: true),
    ).start();
  } else if (isMobilePlatform) {
    BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: periodicSyncInterval.inMinutes,
        forceAlarmManager: false,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        requiresBatteryNotLow: true,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.ANY,
      ),
      (String taskId) async {
        _log.info('starting background sync');
        await RemoteSyncer.instance.synchronize(withFinalRefresh: true);
      },
    ).then((int status) {
      _log.info('background task configured: $status');
    }).catchError((e) {
      _log.info('failed to configure background task: $e');
    });
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
      if (linkType == Deeplink.invalid) return;

      void pushOrGoLogin(Uri uri) {
        if (WallabagInstance.isReady) {
          router.push(uri.toString());
        } else {
          router.go('/login');
        }
      }

      switch (linkType) {
        case Deeplink.save:
          pushOrGoLogin(uri);
        default:
          router.go(uri.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'Frigoligo',
      theme: ThemeData(colorScheme: schemeLight, useMaterial3: true),
      darkTheme: ThemeData(colorScheme: schemeDark, useMaterial3: true),
      themeMode: ref.watch(themeModeProvider),
      locale: ref.watch(languageProvider).locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      restorationScopeId: 'app',
    );
  }

  @override
  void dispose() {
    _deeplinksSubscription?.cancel();
    super.dispose();
  }
}
