import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  private var articleSheetViewModel: ArticleSheetViewModel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
      AppBadgePlugin.register(with: registrar(forPlugin: "AppBadgePlugin")!)
      let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)
      let flutterVC = window!.rootViewController as! FlutterViewController
      articleSheetViewModel = ArticleSheetViewModel(binaryMessenger: flutterVC.binaryMessenger, presenter: flutterVC)
      return result
  }
}
