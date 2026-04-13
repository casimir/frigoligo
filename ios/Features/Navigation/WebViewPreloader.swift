import WebKit

/// Prewarms the WKWebView web content process and vends fresh configurations.
///
/// On iOS 15+ all WKWebView instances share a single process automatically,
/// so creating a warmup view early is sufficient to keep the process alive.
/// WKWebViewConfiguration must NOT be shared across WKWebView instances.
@MainActor
final class WebViewPreloader: NSObject, WKNavigationDelegate {
  static let shared = WebViewPreloader()

  private enum InjectionTime: String, Codable {
    case atDocumentStart, atDocumentEnd
  }

  private struct ManifestEntry: Codable {
    let name: String
    let path: String
    let preScript: String?
    let postScript: String?
    let injectionTime: InjectionTime
    let copyToFS: [String]?
  }

  private struct LoadedScript {
    let source: String
    let injectionTime: WKUserScriptInjectionTime
  }

  private var scripts: [LoadedScript]
  private var warmupView: WKWebView?
  private var warmupStart: Date?
  private(set) var webRoot: URL!
  static var webRoot: URL { shared.webRoot }

  private override init() {
    let base = Bundle.main.bundleURL.appendingPathComponent("Frameworks/App.framework")
    let fm = FileManager.default

    func assetURL(_ relativePath: String) -> URL {
      base.appendingPathComponent(relativePath)
    }

    func load(_ relativePath: String) -> String? {
      let url = assetURL(relativePath)
      do {
        return try String(contentsOf: url, encoding: .utf8)
      } catch {
        print("[WebViewPreloader] FAILED \(relativePath): \(error)")
        return nil
      }
    }

    func copyAsset(_ sourcePath: String, _ relativePath: String) {
      let sourceURL = assetURL(sourcePath)
      let destURL = webRoot.appendingPathComponent(relativePath)
      do {
        try fm.createDirectory(
          at: destURL.deletingLastPathComponent(), withIntermediateDirectories: true)
        try fm.copyItem(at: sourceURL, to: destURL)
      } catch {
        print("[WebViewPreloader] copyAsset FAILED \(sourcePath): \(error)")
      }
    }

    webRoot = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
      .appendingPathComponent("www")

    try? fm.removeItem(at: webRoot)
    try? fm.createDirectory(at: webRoot, withIntermediateDirectories: true)

    var entries: [ManifestEntry] = []

    if let manifestJson = load("flutter_assets/assets/www/scripts/manifest.json"),
      let data = manifestJson.data(using: .utf8),
      let decoded = try? JSONDecoder().decode([ManifestEntry].self, from: data)
    {
      entries = decoded
    } else {
      print("[WebViewPreloader] manifest.json failed to load or parse")
    }

    var loaded: [LoadedScript] = []

    for entry in entries {
      guard var source = load("flutter_assets/\(entry.path)") else {
        print("[WebViewPreloader] \(entry.name) NOT loaded, user script skipped")
        continue
      }

      if let preScript = entry.preScript {
        source = preScript + "\n" + source
      }

      if let postScript = entry.postScript {
        source = source + "\n" + postScript
      }

      let injTime: WKUserScriptInjectionTime =
        entry.injectionTime == .atDocumentStart ? .atDocumentStart : .atDocumentEnd

      loaded.append(
        LoadedScript(
          source: "console.log('[WebViewPreloader] \(entry.name) loaded');\n" + source,
          injectionTime: injTime
        ))
    }

    scripts = loaded

    super.init()

    let copyStart = Date()
    for entry in entries {
      if let copyPaths = entry.copyToFS {
        for copyPath in copyPaths {
          copyAsset(
            "flutter_assets/assets/www/\(copyPath)",
            copyPath
          )
        }
      }
    }
    print(
      "[WebViewPreloader] copied web assets in \(Int(Date().timeIntervalSince(copyStart) * 1000))ms"
    )

    let wv = WKWebView(frame: .zero, configuration: makeConfiguration())
    wv.navigationDelegate = self
    warmupView = wv
    warmupStart = Date()
    print("[WebViewPreloader] warmup: starting")
    wv.loadHTMLString("", baseURL: nil)
  }

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    let elapsed = warmupStart.map { Int(Date().timeIntervalSince($0) * 1000) }
    print("[WebViewPreloader] warmup: done" + (elapsed.map { " in \($0)ms" } ?? ""))
  }

  func makeConfiguration() -> WKWebViewConfiguration {
    let config = WKWebViewConfiguration()

    for script in scripts {
      config.userContentController.addUserScript(
        WKUserScript(
          source: script.source,
          injectionTime: script.injectionTime,
          forMainFrameOnly: true
        ))
    }

    return config
  }
}
