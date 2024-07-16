import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:universal_platform/universal_platform.dart';

import 'app_info.dart';
import 'applinks/handler.dart';
import 'constants.dart';
import 'models/db.dart';
import 'providers/background_sync.dart';
import 'providers/router.dart';
import 'providers/settings.dart';
import 'providers/tools/observer.dart';

const enableDebugLogs = false;
final _log = Logger('main');

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
    if (record.stackTrace != null) {
      line += '\n${record.stackTrace}';
    }
    debugPrint(line.trimRight());
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

  if (UniversalPlatform.isIOS) {
    await SharedPreferenceAppGroup.setAppGroup(appGroupId);
  }

  await AppInfo.init();
  await DB.init(kDebugMode);
  await SettingsValues.init();

  _log.info('app version: ${AppInfo.versionVerbose}');
  _log.info('platform:    ${UniversalPlatform.operatingSystem}');
  if (!UniversalPlatform.isWeb) {
    _log.info('os version:  ${Platform.operatingSystemVersion}');
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
