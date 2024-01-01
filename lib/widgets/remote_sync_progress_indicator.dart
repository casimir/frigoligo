import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../buildcontext_extension.dart';
import '../services/remote_sync.dart';
import '../wallabag/wallabag.dart';

final _log = Logger('widgets.remote_sync_progress_reporter');

class RemoteSyncProgressIndicator extends StatelessWidget {
  const RemoteSyncProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RemoteSyncer?>();
    if (provider == null) {
      _log.warning('RemoteSyncProgressReporter: provider is null');
    }

    final error = provider?.lastError;
    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (error is WallabagError && error.isInvalidTokenError) {
          final result = await showOkCancelAlertDialog(
            context: context,
            title: context.L.session_renewDialogTitle,
            message: context.L.session_renewDialogMessage,
            okLabel: context.L.login_actionLogin,
          );
          if (result == OkCancelResult.ok) {
            await WallabagInstance.get().resetTokenData();
            if (context.mounted) {
              context.go('/login');
            }
          }
        } else {
          final snackbar = SnackBar(content: Text(error.toString()));
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(snackbar);
        }
      });
    }

    if (provider == null || error != null || !provider.isWorking) {
      return const SizedBox.shrink();
    } else {
      return LinearProgressIndicator(value: provider.progressValue);
    }
  }
}
