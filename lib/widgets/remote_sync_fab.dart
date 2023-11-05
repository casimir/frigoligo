import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/remote_sync.dart';

class RemoteSyncFAB extends StatelessWidget {
  const RemoteSyncFAB({super.key, this.showIf = true});

  final bool showIf;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RemoteSyncer?>();
    final showButton = showIf &&
        provider != null &&
        !provider.isWorking &&
        provider.pendingCount > 0;

    if (showButton) {
      return FloatingActionButton.extended(
        icon: const Icon(Icons.sync),
        label: Text('${provider.pendingCount} actions'),
        onPressed: () => provider.synchronize(),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
