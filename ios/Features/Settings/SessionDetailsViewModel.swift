import Flutter

@MainActor
class SessionDetailsViewModel: ObservableObject {
  private let flutterApi: SessionDetailsFlutterApi

  init(binaryMessenger: FlutterBinaryMessenger) {
    self.flutterApi = SessionDetailsFlutterApi(binaryMessenger: binaryMessenger)
  }

  func getSessionData() async -> SessionData? {
    await withCheckedContinuation { continuation in
      flutterApi.getSessionData { result in
        continuation.resume(returning: try? result.get())
      }
    }
  }

  func logout() {
    flutterApi.logout { _ in }
  }

  func refreshToken() {
    flutterApi.refreshToken { _ in }
  }
}
