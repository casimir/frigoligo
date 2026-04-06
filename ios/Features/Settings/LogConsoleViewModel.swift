import Flutter

@MainActor
class LogConsoleViewModel: ObservableObject {
  private let flutterApi: LogConsoleFlutterApi

  init(binaryMessenger: FlutterBinaryMessenger) {
    self.flutterApi = LogConsoleFlutterApi(binaryMessenger: binaryMessenger)
  }

  func getLogs(onlyCurrentRun: Bool) async -> [NativeLogEntry] {
    await withCheckedContinuation { continuation in
      flutterApi.getLogs(onlyCurrentRun: onlyCurrentRun) { result in
        continuation.resume(returning: (try? result.get()) ?? [])
      }
    }
  }

  func clearLogs() {
    flutterApi.clearLogs { _ in }
  }
}
