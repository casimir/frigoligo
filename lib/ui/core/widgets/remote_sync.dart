import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../buildcontext_extension.dart';
import '../../../config/dependencies.dart';
import '../../../services/remote_sync.dart';

class RemoteSyncFAB extends ConsumerWidget {
  const RemoteSyncFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(remoteSyncerProvider);
    final syncer = ref.read(remoteSyncerProvider.notifier);

    if (!syncState.isWorking && syncState.pendingCount > 0) {
      return FloatingActionButton.extended(
        icon: const Icon(Icons.sync),
        label: Text(context.L.syncer_pendingActions(syncState.pendingCount)),
        onPressed: () => syncer.synchronize(),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class RemoteSyncProgressIndicator extends ConsumerWidget
    implements PreferredSizeWidget {
  const RemoteSyncProgressIndicator({super.key, this.idleWidget, this.height});

  final Widget? idleWidget;
  final double? height;

  @override
  Size get preferredSize => Size.fromHeight(height ?? 4.0);

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
            final ServerSessionRepository serverSessionRepository = dependencies
                .get();
            final session = serverSessionRepository.getSession();
            await serverSessionRepository.save(session!.invalidated());
            if (context.mounted) {
              final params = session.wallabag!;
              final uri = Uri(path: '/login', queryParameters: params.toJson());
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
      return idleWidget ??
          Container(height: height ?? 4.0, color: Colors.transparent);
    } else {
      return LinearProgressIndicator(value: syncState.progressValue);
    }
  }
}
