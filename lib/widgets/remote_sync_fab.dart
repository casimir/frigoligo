import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../buildcontext_extension.dart';
import '../services/remote_sync.dart';

class RemoteSyncFAB extends ConsumerWidget {
  const RemoteSyncFAB({super.key, this.showIf = true});

  final bool showIf;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncer = ref.watch(remoteSyncerProvider);
    final showButton = showIf && !syncer.isWorking && syncer.pendingCount > 0;

    if (showButton) {
      return FloatingActionButton.extended(
        icon: const Icon(Icons.sync),
        label: Text(context.L.syncer_pendingActions(syncer.pendingCount)),
        onPressed: () => syncer.synchronize(),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
