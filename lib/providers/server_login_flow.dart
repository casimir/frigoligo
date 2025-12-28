import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/dependencies.dart';
import '../server/check.dart';

part '_g/server_login_flow.freezed.dart';
part '_g/server_login_flow.g.dart';

@freezed
sealed class FlowState with _$FlowState {
  const factory FlowState.initializing() = FSInitializing;
  const factory FlowState.ready([Map<String, String>? initial]) = FSReady;
  const factory FlowState.checking() = FSChecking;
  const factory FlowState.checked(ServerCheck check) = FSChecked;
}

@riverpod
class ServerLoginFlow extends _$ServerLoginFlow {
  Map<String, String>? _currentData;

  @override
  FlowState build() {
    return const FlowState.ready();
  }

  Future<void> checkFor(String server, bool selfSigned) async {
    state = const FlowState.checking();
    final check = await checkServerState(server, selfSigned);
    state = FlowState.checked(check);
  }

  Future<void> reset({Map<String, String>? fieldsData}) async {
    if (fieldsData != null) {
      _currentData = fieldsData;
    }

    if (_currentData == null) {
      state = const FlowState.initializing();
      final ServerSessionRepository serverSessionRepository = dependencies
          .get();
      final session = serverSessionRepository.getSession();
      if (session?.wallabag != null) {
        _currentData = Map.castFrom(session!.wallabag!.toJson());
      }
    }

    state = FlowState.ready(_currentData);
  }
}
