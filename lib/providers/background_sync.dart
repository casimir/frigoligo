import 'package:background_fetch/background_fetch.dart';
import 'package:logging/logging.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:universal_platform/universal_platform.dart';

import '../constants.dart';
import '../services/remote_sync.dart';

part 'background_sync.g.dart';

final _log = Logger('background_sync');

@riverpod
void backgroundSync(BackgroundSyncRef ref) {
  if (periodicSyncSupported) {
    _log.info('starting periodic sync');
    NeatPeriodicTaskScheduler(
      interval: periodicSyncInterval,
      name: 'background-sync',
      timeout: periodicSyncTimeout,
      task: () async => await ref
          .read(remoteSyncerProvider.notifier)
          .synchronize(withFinalRefresh: true),
    ).start();
  } else if (UniversalPlatform.isMobile) {
    BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: periodicSyncInterval.inMinutes,
        forceAlarmManager: false,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        requiresBatteryNotLow: true,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.ANY,
      ),
      (String taskId) async {
        _log.info('starting background sync');
        await ref
            .read(remoteSyncerProvider.notifier)
            .synchronize(withFinalRefresh: true);
      },
    ).then((int status) {
      _log.info('background task configured: $status');
    }).catchError((e) {
      _log.info('failed to configure background task: $e');
    });
  }
}
