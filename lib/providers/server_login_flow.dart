import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../wallabag/utils.dart';

part 'server_login_flow.g.dart';

@riverpod
class ServerLoginFlow extends _$ServerLoginFlow {
  WallabagServerCheck? _serverCheck;
  WallabagServerCheck get serverCheck => _serverCheck!;

  @override
  FlowState build() {
    return FlowState.uninitialized;
  }

  void startCheckFor(String server) {
    _serverCheck = null;
    state = FlowState.checking;
    checkWallabagServer(server).then((value) {
      _serverCheck = value;
      state = FlowState.checked;
    });
  }

  void reset() {
    _serverCheck = null;
    state = FlowState.uninitialized;
  }
}

enum FlowState {
  uninitialized,
  checking,
  checked,
}
