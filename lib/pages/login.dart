import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cadanse/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../buildcontext_extension.dart';
import '../data/services/local/storage/database/database.dart';
import '../providers/server_login_flow.dart';
import '../server/providers/client.dart';
import 'login_flow/check_server.dart';
import 'login_flow/login_credentials.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late Map<String, String>? _currentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: mediumBreakpoint),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    final flowState = ref.watch(serverLoginFlowProvider);

    if (flowState case FSReady(initial: final initial)) {
      _currentData = initial;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // ask for confirmation if there is an existing session
        // skip it if some initial data is provided (deeplink)
        if (initial == null) {
          ref.read(sessionProvider.future).then((session) {
            if (session != null) {
              _triggerConfirmationDialog();
            }
          });
        }
      });
    }

    final flowServer = LoginFlowServer(initial: _currentData?['server']);
    final body = switch (flowState) {
      FSInitializing() =>
        const Center(child: CircularProgressIndicator.adaptive()),
      FSReady() || FSChecking() => flowServer,
      FSChecked(check: final check) when !check.isValid => flowServer,
      FSChecked() => null,
    };
    if (body != null) return body;

    return LoginFlowCredentials(
      serverCheck: (flowState as FSChecked).check,
      initial: _currentData ?? {},
      onReset: () => setState(() {
        _currentData = null;
      }),
    );
  }

  Future<void> _triggerConfirmationDialog() async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: context.L.login_existingSessionDialogTitle,
      message: context.L.login_existingSessionDialogMessage,
      okLabel: context.L.login_existingSessionDialogConfirm,
      isDestructiveAction: true,
    );
    if (result == OkCancelResult.ok) {
      await DB().clear();
      await ref.read(sessionProvider.notifier).logout();
    } else {
      if (mounted) context.go('/');
    }
  }
}
