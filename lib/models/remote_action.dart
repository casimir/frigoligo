import 'dart:convert';

import 'package:isar/isar.dart';

import '../services/remote_sync_actions/base.dart';

part 'remote_action.g.dart';

@collection
class RemoteAction {
  RemoteAction({
    required this.id,
    this.createdAt,
    this.keyCode,
    this.className,
    this.jsonParams,
  });

  final int id;
  final DateTime? createdAt;
  final int? keyCode;
  final String? className;
  final String? jsonParams;

  factory RemoteAction.fromRSA(int id, RemoteSyncAction action) {
    // TODO can't call isar.remoteActions.autoIncrement() here?
    return RemoteAction(
      id: id,
      keyCode: action.hashCode,
      createdAt: DateTime.now(),
      className: action.runtimeType.toString(),
      jsonParams: jsonEncode(action.params()),
    );
  }

  RemoteSyncAction toRSA() {
    final json = jsonDecode(jsonParams!);
    return RemoteSyncAction.fromParams(className!, json);
  }
}
