import 'dart:io' show Platform;

import 'package:background_fetch/background_fetch.dart';
import 'package:cadanse/layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ProviderScope, ConsumerWidget, WidgetRef;
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

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
import 'providers/query.dart';
import 'providers/settings.dart';
import 'services/remote_sync.dart';
import 'services/wallabag_storage.dart';
import 'wallabag/wallabag.dart';

final _log = Logger('frigoligo');

void main() async {
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    DB.appendLog(record);
    var line =
        '[${record.time}] ${record.level.name} ${record.loggerName} ${record.message}';
    if (record.error != null) {
      line += ' (${record.error})';
    }
    debugPrint(line);
  });
  PlatformDispatcher.instance.onError = (error, stack) {
    _log.severe('uncaught error', error, stack);
    return false;
  };
  _log.info('starting app');

  // after this line using `await` is OK
  WidgetsFlutterBinding.ensureInitialized();

  await DB.init(kDebugMode);
  await WallabagInstance.init();
  await SettingsValues.init();
  final info = await PackageInfo.fromPlatform();
  _log.info('version:    ${info.version}+${info.buildNumber}');
  _log.info('platform:   ${Platform.operatingSystem}');
  _log.info('os version: ${Platform.operatingSystemVersion}');

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

  runApp(const ProviderScope(child: MyApp()));
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
    builder: (context, state) => ChangeNotifierProvider.value(
      value: state.extra as WallabagStorage,
      child: const SettingsPage(),
    ),
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
      return ChangeNotifierProvider(
        create: (_) => ArticleProvider(id),
        builder: (context, _) => ArticlePage(articleId: id),
      );
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
    return _MainContainer(
      initialArticleId: openArticleId ?? settings[Sk.selectedArticleId],
      openArticle: openArticleId != null,
    );
  }
}

class _MainContainer extends StatefulWidget {
  const _MainContainer({this.initialArticleId, this.openArticle = false});

  final int? initialArticleId;
  final bool openArticle;

  @override
  State<_MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<_MainContainer> {
  bool isFirstInit = false;
  int? deepLinkHandledFor;
  int? _selectedId;

  bool get deepLinkHandled =>
      deepLinkHandledFor != null &&
      deepLinkHandledFor == widget.initialArticleId;

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
        ChangeNotifierProvider(create: (_) => QueryProvider()),
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

    _handleInitial(onItemSelect, false);

    return ListingPage(
      onItemSelect: onItemSelect,
      initialArticleId: widget.initialArticleId,
    );
  }

  Widget _buildWideLayout() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ArticleProvider>(
            create: (_) => ArticleProvider(_selectedId ?? 0)),
        ChangeNotifierProvider<Expander>(create: (_) => Expander()),
      ],
      builder: (context, _) {
        void onItemSelect(int articleId) {
          if (context.mounted) {
            setState(() {
              _selectedId = articleId;
              context.read<ArticleProvider>().updateId(_selectedId!);
            });
          }
        }

        _handleInitial(onItemSelect, true);

        final expander = context.watch<Expander>();
        return Row(
          children: [
            if (!expander.expanded)
              Flexible(
                flex: 1,
                child: ListingPage(
                  onItemSelect: onItemSelect,
                  initialArticleId: _selectedId,
                ),
              ),
            Flexible(
              flex: 2,
              child: ArticlePage(
                articleId: _selectedId ?? 0,
                withProgressIndicator: expander.expanded,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDynamicLayout() {
    return ChangeNotifierProvider(
      create: (_) => ArticleProvider(_selectedId ?? 0),
      builder: (context, _) {
        void onItemSelect(int articleId) {
          if (context.mounted) {
            setState(() {
              _selectedId = articleId;
              context.read<ArticleProvider>().updateId(_selectedId!);
            });
            if (context.canPop()) {
              context.pop();
            }
          }
        }

        _handleInitial(onItemSelect, true);
        final forcedOpen = isFirstInit;
        isFirstInit = false;

        return ArticlePage(
          articleId: _selectedId ?? 0,
          drawer: SizedBox(
            width: idealListingWidth,
            child: ListingPage(
              onItemSelect: onItemSelect,
              initialArticleId: _selectedId,
            ),
          ),
          forcedDrawerOpen: forcedOpen,
        );
      },
    );
  }

  void _handleInitial(void Function(int) onItemSelect, bool forceOpen) {
    if (widget.initialArticleId != null && (forceOpen || widget.openArticle)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!deepLinkHandled) {
          onItemSelect(widget.initialArticleId!);
          deepLinkHandledFor = widget.initialArticleId;
        }
      });
    }
  }
}
