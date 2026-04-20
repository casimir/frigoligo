import Flutter
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  private var articleSheetViewModel: ArticleSheetViewModel?
  private var authGateViewModel: AuthGateViewModel?
  private var licensesViewModel: LicensesViewModel?
  private var logConsoleViewModel: LogConsoleViewModel?
  private var loginViewModel: LoginViewModel?
  private var navigationViewModel: NavigationSplitViewModel?
  private var sessionDetailsViewModel: SessionDetailsViewModel?
  private var settingsViewModel: SettingsViewModel?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    _ = WebViewPreloader.shared  // kicks off JS compilation before UI is built

    guard let windowScene = scene as? UIWindowScene,
      let engine = (UIApplication.shared.delegate as? AppDelegate)?.engine
    else { return }

    let messenger = engine.binaryMessenger

    let authGateVM = AuthGateViewModel(binaryMessenger: messenger)
    let licensesVM = LicensesViewModel(binaryMessenger: messenger)
    let logConsoleVM = LogConsoleViewModel(binaryMessenger: messenger)
    let loginVM = LoginViewModel(binaryMessenger: messenger)
    let navigationVM = NavigationSplitViewModel(binaryMessenger: messenger)
    let sessionDetailsVM = SessionDetailsViewModel(binaryMessenger: messenger)
    let settingsVM = SettingsViewModel(binaryMessenger: messenger)

    self.authGateViewModel = authGateVM
    self.licensesViewModel = licensesVM
    self.logConsoleViewModel = logConsoleVM
    self.loginViewModel = loginVM
    self.navigationViewModel = navigationVM
    self.sessionDetailsViewModel = sessionDetailsVM
    self.settingsViewModel = settingsVM

    let rootVC = UIHostingController(
      rootView: AppView()
        .environmentObject(authGateVM)
        .environmentObject(licensesVM)
        .environmentObject(logConsoleVM)
        .environmentObject(loginVM)
        .environmentObject(navigationVM)
        .environmentObject(sessionDetailsVM)
        .environmentObject(settingsVM)
    )
    articleSheetViewModel = ArticleSheetViewModel(
      binaryMessenger: messenger,
      presenter: rootVC
    )

    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = rootVC
    window.makeKeyAndVisible()
    self.window = window
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    SystemBridge.shared?.notifyAppResumed()
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    (UIApplication.shared.delegate as? AppDelegate)?.scheduleBackgroundSync()
  }
}
