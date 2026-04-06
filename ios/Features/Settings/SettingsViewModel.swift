import Flutter

class SettingsViewModel: NSObject, ObservableObject, SettingsApi {
  @Published var appSettings: AppSettings = AppSettings(
    appBadge: false, tagSaveEnabled: false, tagSaveLabel: "inbox")

  private let flutterApi: SettingsFlutterApi

  init(binaryMessenger: FlutterBinaryMessenger) {
    self.flutterApi = SettingsFlutterApi(binaryMessenger: binaryMessenger)
    super.init()
    SettingsApiSetup.setUp(binaryMessenger: binaryMessenger, api: self)
  }

  func updateAppSettings(settings: AppSettings) throws {
    if appSettings != settings { appSettings = settings }
  }

  func setAppSettings(_ s: AppSettings) {
    appSettings = s
    flutterApi.setAppSettings(settings: s) { _ in }
  }

  func clearCache() {
    flutterApi.clearCache { _ in }
  }
}
