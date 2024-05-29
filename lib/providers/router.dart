import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../main.dart';
import '../pages/article.dart';
import '../pages/logconsole.dart';
import '../pages/login.dart';
import '../pages/save.dart';
import '../pages/session_details.dart';
import '../pages/settings.dart';
import '../wallabag/wallabag.dart';
import 'article.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => !WallabagInstance.isReady ? '/login' : null,
      builder: (context, state) {
        final rawArticleId = state.uri.queryParameters['articleId'];
        return HomePage(
          openArticleId:
              rawArticleId != null ? int.tryParse(rawArticleId) : null,
        );
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) =>
          LoginPage(initial: state.uri.queryParameters),
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
      builder: (context, state) => const LogConsolePage(),
    ),
    GoRoute(
      path: '/article/current',
      builder: (context, state) => const ArticlePage(),
    ),
    GoRoute(
      path: '/articles/:id',
      redirect: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        if (id <= 0) return null;
        ref.read(currentArticleProvider.notifier).change(id);
        return '/?articleId=$id';
      },
    ),
    GoRoute(
      path: '/save',
      builder: (context, state) =>
          SavePage(url: state.uri.queryParameters['url']),
    ),
  ]);
}
