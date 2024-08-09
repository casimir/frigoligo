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
import '../server/providers/client.dart';
import 'article.dart';
import 'server_login_flow.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  Future<String?> loginRedirect(context, state) => ref
      .read(sessionProvider.future)
      .then((session) => session == null ? '/login' : null);

  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: loginRedirect,
        builder: (context, state) {
          final rawArticleId = state.uri.queryParameters['articleId'];
          final articleId =
              rawArticleId != null ? int.tryParse(rawArticleId) : null;
          ref.read(currentArticleProvider.future).then((article) {
            final currentId = article?.id;
            if (articleId != null && articleId != currentId) {
              ref.read(openArticleProvider.notifier).schedule(articleId);
            }
          });
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          final fields = state.uri.queryParameters;
          if (fields.isNotEmpty) {
            ref
                .read(serverLoginFlowProvider.notifier)
                .reset(fieldsData: fields);
          }
          return const LoginPage();
        },
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
        redirect: loginRedirect,
        builder: (context, state) =>
            SavePage(url: state.uri.queryParameters['url']),
      ),
    ],
  );
}
