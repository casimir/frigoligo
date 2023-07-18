import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frigoligo/providers/article.dart';
import 'package:frigoligo/wallabag/wallabag.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'models/db.dart';
import 'pages/article.dart';
import 'pages/listing.dart';
import 'pages/login.dart';
import 'services/wallabag.dart';

final _log = Logger('frigoligo');

// TODO
// 0.1
// - [x] article persistence
// - [x] api pagination
// - [x] article list filtering
// - [x] smart full sync (with since)
// - [x] refresh progress indicator
// - [x] auto refresh of article view
// - [x] split views on wide screens (manual switch?)
// - [x] check FTUE (/!\ first sync) and reset workflow
// - [x] set up logos and launch screen
// - [x] Add an about section with the version and licenses and stuff...
// - [ ] server selection -> https://github.com/wallabag/docker#sqlite
// 0.2
// - [ ] unit tests (at least for WallabagClient)
// - [ ] padding and spacing everywhere
// - [ ] handle server side deletion of articles
// - [ ] handle tags
// - [ ] translations
// 1.0
// - [ ] background sync
// - [ ] notification badge with https://pub.dev/packages/flutter_app_badger ?
// - [ ] reader mode settings
// - [ ] toggle unread/archived and starred/unstarred
// - [ ] full text search
// - [ ] use (when it's easy) Cupertino design system on iOS/macOS
// - [ ] desktop window management https://pub.dev/packages/window_manager

void main() {
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    var line =
        '[${record.time}] ${record.level.name} ${record.loggerName} ${record.message}';
    if (record.error != null) {
      line += ' (${record.error})';
    }
    debugPrint(line);
  });
  _log.info('Starting Frigoligo');
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

class _MainContainerState extends State<_MainContainer> {
  int? _selectedId;

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
                  builder: (_, __) => ArticlePage(articleId: article.id!)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWideLayout() {
    return ChangeNotifierProvider(
      create: (_) => ArticleProvider(_selectedId ?? 0),
      builder: (context, _) {
        return Row(
          children: [
            Flexible(
              flex: 1,
              child: ChangeNotifierProvider(
                create: (context) => ArticlesProvider(),
                child: ListingPage(
                  onItemSelect: (article) => setState(() {
                    _selectedId = article.id;
                    context.read<ArticleProvider>().updateId(_selectedId!);
                  }),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: ArticlePage(articleId: _selectedId ?? 0),
            ),
          ],
        );
      },
    );
  }
}
