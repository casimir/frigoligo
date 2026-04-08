import Flutter

@MainActor
class LoginViewModel: ObservableObject {
  private let flutterApi: LoginFlutterApi

  init(binaryMessenger: FlutterBinaryMessenger) {
    self.flutterApi = LoginFlutterApi(binaryMessenger: binaryMessenger)
  }

  func checkServer(url: String, selfSigned: Bool) async -> ServerCheckResult? {
    await withCheckedContinuation { continuation in
      flutterApi.checkServer(url: url, selfSigned: selfSigned) { result in
        continuation.resume(returning: try? result.get())
      }
    }
  }

  func loginWallabag(
    url: String, selfSigned: Bool,
    clientId: String, clientSecret: String,
    username: String, password: String
  ) async -> String? {
    await withCheckedContinuation { continuation in
      flutterApi.loginWallabag(
        url: url, selfSigned: selfSigned,
        clientId: clientId, clientSecret: clientSecret,
        username: username, password: password
      ) { result in
        switch result {
        case .success(let message): continuation.resume(returning: message)
        case .failure(let error): continuation.resume(returning: error.localizedDescription)
        }
      }
    }
  }

  func loginFreon(url: String, selfSigned: Bool, token: String) async -> String? {
    await withCheckedContinuation { continuation in
      flutterApi.loginFreon(url: url, selfSigned: selfSigned, token: token) { result in
        switch result {
        case .success(let message): continuation.resume(returning: message)
        case .failure(let error): continuation.resume(returning: error.localizedDescription)
        }
      }
    }
  }

  func loadDemoMode() async {
    await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
      flutterApi.loadDemoMode { _ in
        continuation.resume()
      }
    }
  }
}
