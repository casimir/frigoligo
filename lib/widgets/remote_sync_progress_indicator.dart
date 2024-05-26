import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../buildcontext_extension.dart';
import '../services/remote_sync.dart';
import '../wallabag/wallabag.dart';

class RemoteSyncProgressIndicator extends ConsumerWidget {
  const RemoteSyncProgressIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncer = ref.watch(remoteSyncerProvider);

    final error = syncer.lastError;
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

    if (error != null || !syncer.isWorking) {
      return const SizedBox.shrink();
    } else {
      return LinearProgressIndicator(value: syncer.progressValue);
    }
  }
}
