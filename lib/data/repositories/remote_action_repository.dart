import 'dart:convert';

import '../../domain/repositories.dart';
import '../../domain/sync/remote_actions.dart';
import '../services/local/storage/storage_service.dart';

class RemoteActionRepositoryImpl implements RemoteActionRepository {
  RemoteActionRepositoryImpl({required LocalStorageService localStorageService})
    : _localStorageService = localStorageService;

  final LocalStorageService _localStorageService;

  @override
  Future<void> create(RemoteAction action) =>
      _localStorageService.remoteActions.create(
        key: action.hashCode,
        createdAt: DateTime.now(),
        className: action.type.name,
        jsonParams: jsonEncode(action.params),
      );

  @override
  Future<bool> delete(RemoteAction action) async {
    final deleted = await _localStorageService.remoteActions.delete(
      action.hashCode,
    );
    return deleted > 0;
  }

  @override
  Future<void> clear() => _localStorageService.remoteActions.clear();

  @override
  Future<bool> exists(RemoteAction action) =>
      _localStorageService.remoteActions.exists(action.hashCode);

  @override
  Future<int> count() => _localStorageService.remoteActions.count();

  @override
  Future<List<RemoteAction>> getAllOrderedByCreation() async {
    final rows = await _localStorageService.remoteActions
        .getAllOrderedByCreation();
    return rows.map((row) {
      final params = jsonDecode(row.jsonParams) as ActionParams;
      return RemoteAction.fromParams(row.className, params);
    }).toList();
  }
}
