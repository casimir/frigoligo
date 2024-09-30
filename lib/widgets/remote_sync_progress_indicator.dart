import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../buildcontext_extension.dart';
import '../server/providers/client.dart';
import '../services/remote_sync.dart';
import '../wallabag/client.dart';

class RemoteSyncProgressIndicator extends ConsumerWidget {
  const RemoteSyncProgressIndicator({super.key, this.idleWidget});

  final Widget? idleWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(remoteSyncerProvider);

    final error = syncState.lastError;
    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (error is ServerError && error.isInvalidTokenError) {
          final result = await showOkCancelAlertDialog(
            context: context,
            title: context.L.session_renewDialogTitle,
            message: context.L.session_renewDialogMessage,
            okLabel: context.L.login_actionLogin,
          );
          if (result == OkCancelResult.ok) {
            final session = await ref.read(sessionProvider.future);
            await ref.read(sessionProvider.notifier).invalidate();
            if (context.mounted) {
              final params = session!.wallabag!..token = null;
              final uri = Uri(
                path: '/login',
                queryParameters: params.toJson(),
              );
              context.go(uri.toString());
            }
          }
        } else {
          final snackbar = SnackBar(content: Text(error.toString()));
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(snackbar);
        }
      });
    }

    if (error != null || !syncState.isWorking) {
      return idleWidget ?? const SizedBox(height: 4.0);
    } else {
      return LinearProgressIndicator(value: syncState.progressValue);
    }
  }
}
