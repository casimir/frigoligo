import Flutter

@MainActor
class AuthGateViewModel: ObservableObject, AuthGateApi {
  @Published var requiresLogin = false
  @Published var showReauthAlert = false

  init(binaryMessenger: FlutterBinaryMessenger) {
    AuthGateApiSetup.setUp(binaryMessenger: binaryMessenger, api: self)
  }

  func requireLogin() throws {
    requiresLogin = true
  }

  func loginDidComplete() throws {
    requiresLogin = false
    showReauthAlert = false
  }

  func reauthRequired() throws {
    showReauthAlert = true
  }
}
