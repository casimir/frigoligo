import Flutter

@MainActor
class LicensesViewModel: ObservableObject {
  private let flutterApi: LicensesFlutterApi
  @Published private(set) var packages: [NativeLicensePackage] = []

  init(binaryMessenger: FlutterBinaryMessenger) {
    self.flutterApi = LicensesFlutterApi(binaryMessenger: binaryMessenger)
  }

  func loadIfNeeded() async {
    guard packages.isEmpty else { return }
    packages = await withCheckedContinuation { continuation in
      flutterApi.getLicenses { result in
        continuation.resume(returning: (try? result.get()) ?? [])
      }
    }
  }
}
