import 'dart:convert';

import 'package:isar/isar.dart';

import '../services/remote_sync_actions/base.dart';

part 'remote_action.g.dart';

@collection
class RemoteAction {
  RemoteAction();

  Id? id;
  DateTime? createdAt;
  int? key;
  String? className;
  String? jsonParams;

  factory RemoteAction.fromRSA(RemoteSyncAction action) {
    return RemoteAction()
      ..key = action.hashCode
      ..createdAt = DateTime.now()
      ..className = action.runtimeType.toString()
      ..jsonParams = jsonEncode(action.params());
  }

  RemoteSyncAction toRSA() {
    final json = jsonDecode(jsonParams!);
    return RemoteSyncAction.fromParams(className!, json);
  }
}
