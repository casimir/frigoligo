import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../pages/article.dart';
import '../pages/home.dart';
import '../pages/logconsole.dart';
import '../pages/login.dart';
import '../pages/save.dart';
import '../pages/session_details.dart';
import '../pages/settings.dart';
import '../server/client.dart';
import 'article.dart';
import 'open_article.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => !ServerInstance.isReady ? '/login' : null,
        builder: (context, state) {
          final rawArticleId = state.uri.queryParameters['articleId'];
          final articleId =
              rawArticleId != null ? int.tryParse(rawArticleId) : null;
          final currentId = ref.read(currentArticleProvider)?.id;
          if (articleId != null && articleId != currentId) {
            ref.read(openArticleProvider.notifier).schedule(articleId);
          }
          return const HomePage();
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
        path: '/articles/current',
        builder: (context, state) => const ArticlePage(),
      ),
      GoRoute(
        path: '/articles/:id',
        redirect: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          if (id <= 0) return null;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(openArticleProvider.notifier).schedule(id);
          });
          return '/';
        },
      ),
      GoRoute(
        path: '/save',
        builder: (context, state) =>
            SavePage(url: state.uri.queryParameters['url']),
      ),
    ],
  );
}
