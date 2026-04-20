import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  var engine: FlutterEngine?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    UITableView.appearance().sectionHeaderTopPadding = 0
    super.application(application, didFinishLaunchingWithOptions: launchOptions)

    let engine = FlutterEngine(name: "main")
    engine.run()
    GeneratedPluginRegistrant.register(with: engine)
    AppBadgePlugin.register(with: engine.registrar(forPlugin: "AppBadgePlugin")!)
    self.engine = engine

    return true
  }
}
