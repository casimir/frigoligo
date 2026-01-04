import 'dart:convert';

import '../../../../../../domain/sync/remote_actions.dart' as domain;
import '../models/remote_action.drift.dart';

extension RemoteActionExtension on RemoteAction {
  domain.RemoteAction toRemoteAction() {
    final json = jsonDecode(jsonParams);
    return domain.RemoteAction.fromParams(className, json);
  }
}
