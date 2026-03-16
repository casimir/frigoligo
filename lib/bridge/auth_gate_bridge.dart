import '../domain/repositories.dart';
import '../pigeon/bridges.g.dart';

class AuthGateBridge {
  static final _api = AuthGateApi();

  AuthGateBridge({required ServerSessionRepository serverSessionRepository}) {
    if (serverSessionRepository.getSession() == null) {
      _api.requireLogin();
    }
  }

  static void notifyLoginComplete() => _api.loginDidComplete();
}
