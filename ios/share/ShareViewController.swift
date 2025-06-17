//
//  ShareViewController.swift
//  share
//
//  Created by Martin Chaine on 27/08/2023.
//

import Flutter
import UIKit
import UniformTypeIdentifiers
import Social
import SwiftUI

import OSLog
import device_info_plus
import package_info_plus
import path_provider_foundation
import shared_preference_app_group
import shared_preferences_foundation
import sqlite3_flutter_libs
import sqflite_darwin

let logger = Logger()

func devLog(_ message: String) {
    logger.log("[DEV] \(message, privacy: .public)")
}

let frigoligoColor = Color(UIColor(red: 0.31372550129999999, green: 0.61960786580000005, blue: 0.7607843876, alpha: 1.0))

struct ShareExtView: UIViewControllerRepresentable {
  func buildFlutterEngine() -> FlutterEngine {
    let engine = FlutterEngine(name: "share_ext")
    let ok = engine.run(withEntrypoint: "mainNativeShare")
    if (!ok) {
      devLog("ERROR: failed to run FlutterEngine")
    }
    
    FPPDeviceInfoPlusPlugin.register(with: engine.registrar(forPlugin: "FPPDeviceInfoPlusPlugin")!)
    FPPPackageInfoPlusPlugin.register(with: engine.registrar(forPlugin: "FPPPackageInfoPlusPlugin")!)
    PathProviderPlugin.register(with: engine.registrar(forPlugin: "PathProviderPlugin")!)
    SharedPreferenceAppGroupPlugin.register(with: engine.registrar(forPlugin: "SharedPreferenceAppGroupPlugin")!)
    SharedPreferencesPlugin.register(with: engine.registrar(forPlugin: "SharedPreferencesPlugin")!)
    SqflitePlugin.register(with: engine.registrar(forPlugin: "SqflitePlugin")!)
    Sqlite3FlutterLibsPlugin.register(with: engine.registrar(forPlugin: "Sqlite3FlutterLibsPlugin")!)
    
    SavePlugin.register(with: engine.registrar(forPlugin: "SavePlugin")!)
    
    return engine
  }
  
  func makeUIViewController(context: Context) -> some UIViewController {
    let flutterEngine = buildFlutterEngine()
    return FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

extension ZStack {
    func apply<V: View>(@ViewBuilder _ block: (Self) -> V) -> V { block(self) }
}

class ShareViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var layout: some View {
      ZStack {
        // FlutterEngine seems to be needing a View to effectively run the entrypoint.
        ShareExtView()
        CompletionToast(
          vm: ToastViewModel(),
          action: self.doSave,
          didSucceed: { self.exitExtension() },
          onError: { (errorMessage) -> Void in
            self.exitExtension(withErrorMessage: errorMessage)
          },
          strokeColor: frigoligoColor
        )
      }.apply {
        if #available(iOS 18.0, *) {
          $0.toolbarVisibility(.hidden, for: .navigationBar)
        } else {
          $0.navigationBarHidden(true)
        }
      }
    }
    let innerController = UIHostingController(rootView: layout)
    innerController.view.backgroundColor = .clear
    addChild(innerController)
    view.addSubview(innerController.view)
    innerController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      innerController.view.topAnchor.constraint(equalTo: view.topAnchor),
      innerController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      innerController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      innerController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    innerController.didMove(toParent: self)
  }
  
  private func exitExtension(withErrorMessage: String? = nil) {
    if (withErrorMessage != nil) {
      devLog("ERROR: \(withErrorMessage!)")
      let alert = UIAlertController(title: "Error", message: withErrorMessage, preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .default) { _ in
        self.dismiss(animated: true, completion: nil)
        let error = NSError(domain: "net.casimir-lab.frigoligo", code: 0, userInfo: [NSLocalizedDescriptionKey: withErrorMessage!])
        self.extensionContext?.cancelRequest(withError: error)
      }
      alert.addAction(action)
      DispatchQueue.main.async {
        self.present(alert, animated: true, completion: nil)
      }
    } else {
      DispatchQueue.main.async {
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
      }
    }
  }
  
  private func findURLAttachment(for typeIdentifier: String) -> NSItemProvider? {
    extensionContext?.inputItems
      .compactMap { $0 as? NSExtensionItem }
      .first?
      .attachments?
      .first(where: { $0.hasItemConformingToTypeIdentifier(typeIdentifier) })
  }
  
  private func findSharedUrl() async throws -> URL {
    for typeIdentifier in [UTType.url.identifier, UTType.plainText.identifier] {
      guard let attachment = findURLAttachment(for: typeIdentifier) else { continue }
      
      do {
        let item = try await attachment.loadItem(forTypeIdentifier: typeIdentifier)
        switch typeIdentifier {
          case UTType.url.identifier:
            if let url = item as? URL { return url }
          case UTType.plainText.identifier:
            if let text = item as? String, let url = URL(string: text) { return url }
          default:
            break
        }
      } catch {
        devLog("could not extract URL (type: \(typeIdentifier)): \(error)")
      }
    }
    
    throw CompletionError.description("no attachment URL found")
  }
  
  private func doSave() async throws {
    let url = try await findSharedUrl()
    
    do {
      let articleId = try await SavePlugin.shared!.saveArticle(url: url)
      if articleId != nil {
        devLog("article saved with id \(articleId!)")
      } else {
        devLog("the article will be saved with the next successful sync")
      }
    } catch {
      throw CompletionError.description("could not save URL: \(error)")
    }
  }
}

@objc(ShareNavigationController)
class ShareNavigationController: UINavigationController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.setViewControllers([ShareViewController()], animated: false)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
