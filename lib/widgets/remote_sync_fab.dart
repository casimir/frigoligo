import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../buildcontext_extension.dart';
import '../services/remote_sync.dart';

class RemoteSyncFAB extends ConsumerWidget {
  const RemoteSyncFAB({super.key, this.showIf = true, this.alternativeChild});

  final bool showIf;
  final Widget? alternativeChild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(remoteSyncerProvider);
    final syncer = ref.read(remoteSyncerProvider.notifier);
    final showButton =
        showIf && !syncState.isWorking && syncState.pendingCount > 0;

    if (showButton) {
      return FloatingActionButton.extended(
        icon: const Icon(Icons.sync),
        label: Text(context.L.syncer_pendingActions(syncState.pendingCount)),
        onPressed: () => syncer.synchronize(),
      );
    } else {
      return alternativeChild ?? const SizedBox.shrink();
    }
  }
}
