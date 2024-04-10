import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../wallabag/utils.dart';

part 'server_login_flow.g.dart';

@riverpod
class ServerLoginFlow extends _$ServerLoginFlow {
  @override
  (FlowState, WallabagServerCheck?) build() {
    return (FlowState.uninitialized, null);
  }

  void startCheckFor(String server) {
    state = (FlowState.checking, null);
    checkWallabagServer(server).then((value) {
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
