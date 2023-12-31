import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'layout.dart';
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
  await SettingsProvider.init();
  final info = await PackageInfo.fromPlatform();
  _log.info('version: ${info.version}+${info.buildNumber}');

  runApp(const MyApp());
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
        ChangeNotifierProvider(create: (_) => RemoteSyncer.instance),
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
                case Deeplink.article:
                  _router.go('/?articleId=${uri.pathSegments.last}');
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
            // This is ugly but... The point is listen() after _router is ready
            Future.delayed(
              const Duration(milliseconds: 50),
              () => deeplinks.listen(),
            );
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
          locale: null, // TODO add in settings?
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          restorationScopeId: 'app',
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.openArticleId});

  final int? openArticleId;

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsProvider>();
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
  int? deepLinkHandledFor;
  int? _selectedId;

  bool get deepLinkHandled =>
      deepLinkHandledFor != null &&
      deepLinkHandledFor == widget.initialArticleId;

  @override
  Widget build(BuildContext context) {
    final syncer = context.read<RemoteSyncer>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            final provider = WallabagStorage(context.read<SettingsProvider>());
            syncer.wallabag = provider;
            return provider;
          },
          lazy: false, // Just for RemoteSync initialization.
        ),
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

        return ArticlePage(
          articleId: _selectedId ?? 0,
          drawer: SizedBox(
            width: idealListingWidth,
            child: ListingPage(
              onItemSelect: onItemSelect,
              initialArticleId: _selectedId,
            ),
          ),
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
