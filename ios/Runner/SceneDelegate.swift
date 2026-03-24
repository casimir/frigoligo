import Flutter
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  private var articleSheetViewModel: ArticleSheetViewModel?
  private var authGateViewModel: AuthGateViewModel?
  private var navViewModel: NavigationSplitViewModel?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene,
      let engine = (UIApplication.shared.delegate as? AppDelegate)?.engine
    else { return }

    let navigationVM = NavigationSplitViewModel(binaryMessenger: engine.binaryMessenger)
    navigationVM.engine = engine
    self.navViewModel = navigationVM

    let rootVC = UIHostingController(rootView: AppView().environmentObject(navigationVM))
    navigationVM.presenter = rootVC
    articleSheetViewModel = ArticleSheetViewModel(
      binaryMessenger: engine.binaryMessenger,
      presenter: rootVC
    )

    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = rootVC
    window.makeKeyAndVisible()
    self.window = window

    authGateViewModel = AuthGateViewModel(
      window: window,
      engine: engine,
      binaryMessenger: engine.binaryMessenger
    )
  }
}
