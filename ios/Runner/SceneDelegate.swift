import Flutter
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  private var articleSheetViewModel: ArticleSheetViewModel?
  private var authGateViewModel: AuthGateViewModel?
  private var logConsoleViewModel: LogConsoleViewModel?
  private var navigationViewModel: NavigationSplitViewModel?
  private var sessionDetailsViewModel: SessionDetailsViewModel?
  private var settingsViewModel: SettingsViewModel?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene,
      let engine = (UIApplication.shared.delegate as? AppDelegate)?.engine
    else { return }

    let messenger = engine.binaryMessenger
    let logConsoleVM = LogConsoleViewModel(binaryMessenger: messenger)
    let navigationVM = NavigationSplitViewModel(binaryMessenger: messenger)
    let sessionDetailsVM = SessionDetailsViewModel(binaryMessenger: messenger)
    let settingsVM = SettingsViewModel(binaryMessenger: messenger)

    self.logConsoleViewModel = logConsoleVM
    self.navigationViewModel = navigationVM
    self.sessionDetailsViewModel = sessionDetailsVM
    self.settingsViewModel = settingsVM

    let rootVC = UIHostingController(
      rootView: AppView()
        .environmentObject(navigationVM)
        .environmentObject(settingsVM)
        .environmentObject(sessionDetailsVM)
        .environmentObject(logConsoleVM)
    )
    articleSheetViewModel = ArticleSheetViewModel(
      binaryMessenger: messenger,
      presenter: rootVC
    )

    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = rootVC
    window.makeKeyAndVisible()
    self.window = window

    authGateViewModel = AuthGateViewModel(
      window: window,
      engine: engine,
      binaryMessenger: messenger
    )
  }
}
