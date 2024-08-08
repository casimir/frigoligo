import 'dart:convert';

import '../../services/remote_sync_actions/base.dart';
import '../database.dart';

extension RemoteActionExtension on RemoteAction {
  RemoteSyncAction toRSA() {
    final json = jsonDecode(jsonParams);
    return RemoteSyncAction.fromParams(className, json);
  }
}
