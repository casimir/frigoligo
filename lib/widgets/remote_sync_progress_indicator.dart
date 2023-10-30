import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../services/remote_sync.dart';

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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final snackbar = SnackBar(content: Text(error.toString()));
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(snackbar);
      });
    }

    if (provider == null || error != null || !provider.isWorking) {
      return const SizedBox.shrink();
    } else {
      return LinearProgressIndicator(value: provider.progressValue);
    }
  }
}
