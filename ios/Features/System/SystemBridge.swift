import Flutter

class SystemBridge {
  static var shared: SystemBridge?

  private let api: SystemFlutterApi

  init(binaryMessenger: FlutterBinaryMessenger) {
    api = SystemFlutterApi(binaryMessenger: binaryMessenger)
  }

  static func logDebug(_ message: String, logger: String) {
    shared?.log(message, logger: logger, level: "DEBUG")
  }

  static func logInfo(_ message: String, logger: String) {
    shared?.log(message, logger: logger, level: "INFO")
  }

  static func logError(_ message: String, logger: String) {
    shared?.log(message, logger: logger, level: "ERROR")
  }

  func log(_ message: String, logger: String, level: String = "INFO", error: String? = nil) {
    api.log(
      entry: LogData(level: level, loggerName: logger, message: message, error: error)
    ) { _ in }
  }

  func notifyAppResumed() {
    api.onAppResumed { _ in }
  }

  func notifyBackgroundFetch(completion: @escaping () -> Void) {
    api.onBackgroundFetch { _ in completion() }
  }
}
