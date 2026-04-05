import Flutter

class AuthGateViewModel: AuthGateApi {
  private weak var window: UIWindow?
  private weak var engine: FlutterEngine?

  init(window: UIWindow?, engine: FlutterEngine, binaryMessenger: FlutterBinaryMessenger) {
    self.window = window
    self.engine = engine
    AuthGateApiSetup.setUp(binaryMessenger: binaryMessenger, api: self)
  }

  func requireLogin() throws {
    guard let engine, let rootVC = window?.rootViewController,
      rootVC.presentedViewController == nil
    else { return }
    let loginVC = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    loginVC.modalPresentationStyle = .fullScreen
    rootVC.present(loginVC, animated: false)
  }

  func loginDidComplete() throws {
    window?.rootViewController?.presentedViewController?.dismiss(animated: true)
  }
}
