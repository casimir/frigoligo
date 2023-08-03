import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frigoligo/providers/article.dart';
import 'package:frigoligo/wallabag/wallabag.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'models/db.dart';
import 'pages/article.dart';
import 'pages/listing.dart';
import 'pages/login.dart';
import 'services/wallabag.dart';

final _log = Logger('frigoligo');

void main() {
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
  _log.info('starting app');
  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo.fromPlatform().then((info) {
    _log.info('version: ${info.version}+${info.buildNumber}');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      title: 'Frigoligo',
      theme: ThemeData(colorScheme: schemeLight, useMaterial3: true),
      darkTheme: ThemeData(colorScheme: schemeDark, useMaterial3: true),
      themeMode: ThemeMode.system,
      restorationScopeId: 'app',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([DB.init(), WallabagInstance.init()]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WallabagInstance.isReady
              ? const _MainContainer()
              : const LoginPage();
        } else if (snapshot.hasError) {
          _log.severe(
            'failed to finish login process',
            snapshot.error,
            snapshot.stackTrace,
          );
          return Text('ERROR ${snapshot.error}');
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
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
    return shortestSide < 600 ? _buildNarrowLayout() : _buildWideLayout();
  }

  Widget _buildNarrowLayout() {
    return ChangeNotifierProvider(
      create: (_) => ArticlesProvider(),
      child: ListingPage(
        onItemSelect: (article) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                  create: (_) => ArticleProvider(article.id!),
                  builder: (_, __) => ArticlePage(
                        articleId: article.id!,
                        isFullScreen: true,
                      )),
            ),
          );
        },
      ),
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
              child: ChangeNotifierProvider(
                create: (context) => ArticlesProvider(),
                child: ListingPage(
                  onItemSelect: (article) => setState(() {
                    _selectedId.value = article.id;
                    context
                        .read<ArticleProvider>()
                        .updateId(_selectedId.value!);
                  }),
                ),
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
