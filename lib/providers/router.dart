import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/dependencies.dart';
import '../pages/login.dart';
import '../pages/save.dart';
import '../pages/session_details.dart';
import '../pages/settings.dart';
import '../server/providers/client.dart';
import '../ui/home/controllers/home_screen_controller.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/logconsole/viewmodels/logconsole_viewmodel.dart';
import '../ui/logconsole/widgets/logconsole_screen.dart';
import 'server_login_flow.dart';

part '_g/router.g.dart';

@riverpod
GoRouter router(Ref ref) {
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
          return HomeScreen(
            controller: HomeScreenController(
              queryRepository: dependencies.get(),
            ),
            initialArticleId: articleId,
          );
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
        builder: (context, state) {
          final viewModel = LogConsoleViewModel(
            loggerRepository: dependencies.get(),
            sharingService: dependencies.get(),
          );
          return LogConsoleScreen(viewModel: viewModel);
        },
      ),
      GoRoute(
        path: '/save',
        redirect: loginRedirect,
        builder:
            (context, state) => SavePage(url: state.uri.queryParameters['url']),
      ),
    ],
  );
}
