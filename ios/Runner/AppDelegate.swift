import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
      AppBadgePlugin.register(with: registrar(forPlugin: "AppBadgePlugin")!)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
