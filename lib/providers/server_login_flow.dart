import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../server/check.dart';

part 'server_login_flow.g.dart';

@riverpod
class ServerLoginFlow extends _$ServerLoginFlow {
  @override
  (FlowState, ServerCheck?) build() {
    return (FlowState.uninitialized, null);
  }

  void startCheckFor(String server) {
    state = (FlowState.checking, null);
    checkServerState(server).then((value) {
      state = (FlowState.checked, value);
    });
  }

  void reset() {
    state = (FlowState.uninitialized, null);
  }
}

enum FlowState {
  uninitialized,
  checking,
  checked,
}
