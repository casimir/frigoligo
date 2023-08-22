import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frigoligo/pages/logconsole.dart';
import 'package:frigoligo/pages/save.dart';
import 'package:frigoligo/pages/session_details.dart';
import 'package:frigoligo/pages/settings.dart';
import 'package:frigoligo/providers/deeplinks.dart';
import 'package:frigoligo/providers/logconsole.dart';
import 'package:frigoligo/wallabag/wallabag.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'models/db.dart';
import 'pages/article.dart';
import 'pages/listing.dart';
import 'pages/login.dart';
import 'providers/article.dart';
import 'providers/settings.dart';
import 'services/wallabag_storage.dart';

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
  await SettingsProvider.init();
  final info = await PackageInfo.fromPlatform();
  _log.info('version: ${info.version}+${info.buildNumber}');

  runApp(const MyApp());
}

final _router = GoRouter(routes: [
  GoRoute(
    path: '/',
    redirect: (context, state) => !WallabagInstance.isReady ? '/login' : null,
    builder: (context, state) => const HomePage(),
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
        builder: (context, _) => ArticlePage(
          articleId: id,
          isFullScreen: true,
        ),
      );
    },
  ),
  GoRoute(
    path: '/save',
    builder: (context, state) {
      final url = state.uri.queryParameters['url'];
      return SavePage(url: url);
    },
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              SettingsProvider(namespace: kDebugMode ? 'debug' : null),
        ),
        ChangeNotifierProvider(
          create: (context) {
            return DeeplinksProvider(_router.configuration, (linkType, uri) {
              void pushOrGoLogin(Uri uri) {
                if (WallabagInstance.isReady) {
                  _router.push(uri.toString());
                } else {
                  _router.go('/login');
                }
              }

              switch (linkType) {
                case Deeplink.login:
                  _router.go(uri.toString());
                case Deeplink.save:
                  pushOrGoLogin(uri);
                default:
              }
            });
          },
        ),
      ],
      builder: (context, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final deeplinks = context.read<DeeplinksProvider>();
          if (!deeplinks.isListening) {
            deeplinks.listen();
          }
        });

        final themeMode = context
            .select((SettingsProvider settings) => settings[Sk.themeMode]);

        return MaterialApp.router(
          routerConfig: _router,
          title: 'Frigoligo',
          theme: ThemeData(colorScheme: schemeLight, useMaterial3: true),
          darkTheme: ThemeData(colorScheme: schemeDark, useMaterial3: true),
          themeMode: themeMode,
          localizationsDelegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          restorationScopeId: 'app',
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MainContainer();
  }
}

class _MainContainer extends StatefulWidget {
  const _MainContainer();

  @override
  State<_MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<_MainContainer> with RestorationMixin {
  final RestorableIntN _selectedId = RestorableIntN(null);

  @override
  String? get restorationId => 'main';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedId, 'main.selectedId');
  }

  @override
  void dispose() {
    _selectedId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    return ChangeNotifierProvider(
      create: (context) => WallabagStorage(context.read<SettingsProvider>()),
      child: shortestSide < 600 ? _buildNarrowLayout() : _buildWideLayout(),
    );
  }

  Widget _buildNarrowLayout() {
    return ListingPage(
      onItemSelect: (article) => context.push('/articles/${article.id}'),
    );
  }

  Widget _buildWideLayout() {
    return ChangeNotifierProvider(
      create: (_) => ArticleProvider(_selectedId.value ?? 0),
      builder: (context, _) {
        return Row(
          children: [
            Flexible(
              flex: 1,
              child: ListingPage(
                onItemSelect: (article) => setState(() {
                  _selectedId.value = article.id;
                  context.read<ArticleProvider>().updateId(_selectedId.value!);
                }),
              ),
            ),
            Flexible(
              flex: 2,
              child: ArticlePage(
                articleId: _selectedId.value ?? 0,
                isFullScreen: false,
              ),
            ),
          ],
        );
      },
    );
  }
}
