import BackgroundTasks
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  var engine: FlutterEngine?

  private let bgTaskId = "net.casimir-lab.frigoligo.background-sync"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication
      .LaunchOptionsKey: Any]?
  ) -> Bool {
    UITableView.appearance().sectionHeaderTopPadding = 0
    super.application(application, didFinishLaunchingWithOptions: launchOptions)

    let engine = FlutterEngine(name: "main")
    guard engine.run() else {
      fatalError("FlutterEngine failed to run")
    }
    SystemBridge.shared = SystemBridge(binaryMessenger: engine.binaryMessenger)

    BGTaskScheduler.shared.register(forTaskWithIdentifier: bgTaskId, using: nil) { task in
      self.handleBackgroundSync(task: task as! BGAppRefreshTask)
    }

    GeneratedPluginRegistrant.register(with: engine)
    AppBadgePlugin.register(with: engine.registrar(forPlugin: "AppBadgePlugin")!)
    self.engine = engine

    return true
  }

  func scheduleBackgroundSync() {
    #if targetEnvironment(simulator)
      SystemBridge.logDebug(
        "skipping background task scheduling (simulator)",
        logger: "AppDelegate"
      )
      return
    #endif

    let request = BGAppRefreshTaskRequest(identifier: bgTaskId)
    do {
      try BGTaskScheduler.shared.submit(request)
    } catch {
      SystemBridge.logError(
        "failed to schedule background task: \(error)",
        logger: "AppDelegate"
      )
    }
  }

  private func handleBackgroundSync(task: BGAppRefreshTask) {
    scheduleBackgroundSync()
    task.expirationHandler = { task.setTaskCompleted(success: false) }
    guard let bridge = SystemBridge.shared else {
      task.setTaskCompleted(success: false)
      return
    }
    bridge.notifyBackgroundFetch { task.setTaskCompleted(success: true) }
  }
}
