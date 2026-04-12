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
    let version: String?
  }

  private struct LoadedScript {
    let source: String
    let injectionTime: WKUserScriptInjectionTime
  }

  private let scripts: [LoadedScript]
  private var warmupView: WKWebView?
  private var warmupStart: Date?

  private override init() {
    let base = Bundle.main.bundleURL.appendingPathComponent("Frameworks/App.framework")

    func load(_ relativePath: String) -> String? {
      let url = base.appendingPathComponent(relativePath)
      do {
        return try String(contentsOf: url, encoding: .utf8)
      } catch {
        print("[WebViewPreloader] FAILED \(relativePath): \(error)")
        return nil
      }
    }

    var loaded: [LoadedScript] = []

    if let manifestJson = load("flutter_assets/assets/www/scripts/manifest.json"),
      let data = manifestJson.data(using: .utf8),
      let entries = try? JSONDecoder().decode([ManifestEntry].self, from: data)
    {
      for entry in entries {
        guard var source = load("flutter_assets/\(entry.path)") else {
          print("[WebViewPreloader] \(entry.name) NOT loaded, user script skipped")
          continue
        }

        if var preScript = entry.preScript {
          if preScript.contains("%%FONT_PATH%%"),
            let version = entry.version,
            let appSupportDir = FileManager.default.urls(
              for: .applicationSupportDirectory, in: .userDomainMask
            ).first
          {
            let fontDest = appSupportDir.appendingPathComponent("mathjax-fonts")
            let fontSrc = base.appendingPathComponent(
              "flutter_assets/assets/www/scripts/\(entry.name)/fonts"
            )
            WebViewPreloader.syncFonts(from: fontSrc, to: fontDest, version: version)
            let fontPath = fontDest.absoluteString + "/%%FONT%%-font"
            preScript = preScript.replacingOccurrences(of: "%%FONT_PATH%%", with: fontPath)
          }
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
    } else {
      print("[WebViewPreloader] manifest.json failed to load or parse")
    }

    scripts = loaded

    super.init()

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

  private static func syncFonts(from source: URL, to dest: URL, version: String) {
    let versionFile = dest.appendingPathComponent(".version")
    if let installed = try? String(contentsOf: versionFile, encoding: .utf8),
      installed == version
    {
      return
    }
    let fm = FileManager.default
    try? fm.removeItem(at: dest)
    do {
      try fm.copyItem(at: source, to: dest)
      try version.write(to: versionFile, atomically: true, encoding: .utf8)
      print("[WebViewPreloader] fonts synced for MathJax \(version)")
    } catch {
      print("[WebViewPreloader] fonts sync FAILED: \(error)")
    }
  }
}
