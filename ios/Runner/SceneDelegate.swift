import Flutter
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  private var articleSheetViewModel: ArticleSheetViewModel?
  private var authGateViewModel: AuthGateViewModel?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene,
      let engine = (UIApplication.shared.delegate as? AppDelegate)?.engine
    else { return }

    let rootVC = UIHostingController(rootView: AppView())
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
