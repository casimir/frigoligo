import 'dart:io' show Platform;

import 'package:background_fetch/background_fetch.dart';
import 'package:cadanse/layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider; // use ChangeNotifierProvider from provider
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'package:provider/provider.dart';

import 'app_info.dart';
import 'constants.dart';
import 'models/db.dart';
import 'pages/article.dart';
import 'pages/listing.dart';
import 'pages/logconsole.dart';
import 'pages/login.dart';
import 'pages/save.dart';
import 'pages/session_details.dart';
import 'pages/settings.dart';
import 'providers/article.dart';
import 'providers/deeplinks.dart';
import 'providers/expander.dart';
import 'providers/logconsole.dart';
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

final _router = GoRouter(routes: [
  GoRoute(
    path: '/',
    redirect: (context, state) => !WallabagInstance.isReady ? '/login' : null,
    builder: (context, state) {
      final rawArticleId = state.uri.queryParameters['articleId'];
      return HomePage(
        openArticleId: rawArticleId != null ? int.tryParse(rawArticleId) : null,
      );
    },
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => LoginPage(initial: state.uri.queryParameters),
  ),
  GoRoute(
    path: '/settings',
    builder: (context, state) => const SettingsPage(),
  ),
  GoRoute(
    path: '/session',
    builder: (context, state) => const SessionDetailsPage(),
  ),
  GoRoute(
    path: '/logs',
    builder: (context, state) => ChangeNotifierProvider(
      create: (_) => LogConsoleProvider(),
      child: const LogConsolePage(),
    ),
  ),
  GoRoute(
    path: '/articles/:id',
    builder: (context, state) {
      final id = int.parse(state.pathParameters['id']!);
      return (id > 0)
          ? ArticlePage(changeToArticleId: id)
          : const ArticlePage();
    },
  ),
  GoRoute(
    path: '/save',
    builder: (context, state) =>
        SavePage(url: state.uri.queryParameters['url']),
  ),
]);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RemoteSyncer.instance),
        ChangeNotifierProvider(
          create: (context) {
            return DeeplinksProvider(_router.configuration, (linkType, uri) {
              if (linkType == Deeplink.invalid) return;

              void pushOrGoLogin(Uri uri) {
                if (WallabagInstance.isReady) {
                  _router.push(uri.toString());
                } else {
                  _router.go('/login');
                }
              }

              switch (linkType) {
                case Deeplink.article:
                  _router.go('/?articleId=${uri.pathSegments.last}');
                case Deeplink.save:
                  pushOrGoLogin(uri);
                default:
                  _router.go(uri.toString());
              }
            });
          },
        ),
      ],
      builder: (context, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final deeplinks = context.read<DeeplinksProvider>();
          if (!deeplinks.isListening) {
            // This is ugly but... The point is listen() after _router is ready
            Future.delayed(
              const Duration(milliseconds: 50),
              () => deeplinks.listen(),
            );
          }
        });

        return MaterialApp.router(
          routerConfig: _router,
          title: 'Frigoligo',
          theme: ThemeData(colorScheme: schemeLight, useMaterial3: true),
          darkTheme: ThemeData(colorScheme: schemeDark, useMaterial3: true),
          themeMode: ref.watch(themeModeProvider),
          locale: ref.watch(languageProvider).locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          restorationScopeId: 'app',
        );
      },
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key, this.openArticleId});

  final int? openArticleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsProvider);
    final initialArticleId = openArticleId ?? settings[Sk.selectedArticleId];
    if (initialArticleId != null && initialArticleId > 0) {
      ref.read(currentArticleProvider.notifier).change(initialArticleId);
    }

    return _MainContainer(openArticleId: openArticleId);
  }
}

class _MainContainer extends ConsumerStatefulWidget {
  const _MainContainer({this.openArticleId});

  final int? openArticleId;

  @override
  ConsumerState<_MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends ConsumerState<_MainContainer> {
  bool isFirstInit = false;

  @override
  void initState() {
    super.initState();

    isFirstInit = true;
    if (!periodicSyncSupported) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        RemoteSyncer.instance.synchronize(withFinalRefresh: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final syncer = context.read<RemoteSyncer>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => syncer.wallabag!),
      ],
      builder: (_, __) {
        switch (Layout.windowClass(context)) {
          case WindowClass.compact:
            return _buildNarrowLayout();
          case WindowClass.medium:
            return _buildWideLayout();
          case WindowClass.expanded:
            return _buildDynamicLayout();
        }
      },
    );
  }

  Widget _buildNarrowLayout() {
    void onItemSelect(int articleId) {
      context.push('/articles/$articleId');
    }

    return ListingPage(onItemSelect: onItemSelect, showSelectedItem: false);
  }

  Widget _buildWideLayout() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Expander>(create: (_) => Expander()),
      ],
      builder: (context, _) {
        final expander = context.watch<Expander>();
        return Row(
          children: [
            if (!expander.expanded)
              const Flexible(
                flex: 1,
                child: ListingPage(),
              ),
            Flexible(
              flex: 2,
              child: ArticlePage(withProgressIndicator: expander.expanded),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDynamicLayout() {
    void onItemSelect(int articleId) {
      if (context.canPop()) {
        context.pop();
      }
    }

    final forcedOpen = isFirstInit;
    isFirstInit = false;

    return ArticlePage(
      drawer: SizedBox(
        width: idealListingWidth,
        child: ListingPage(onItemSelect: onItemSelect),
      ),
      forcedDrawerOpen: forcedOpen,
    );
  }
}
