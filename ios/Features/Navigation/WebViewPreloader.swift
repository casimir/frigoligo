import WebKit

/// Prewarms the WKWebView web content process and vends fresh configurations.
///
/// On iOS 15+ all WKWebView instances share a single process automatically,
/// so creating a warmup view early is sufficient to keep the process alive.
/// WKWebViewConfiguration must NOT be shared across WKWebView instances.
@MainActor
final class WebViewPreloader: NSObject, WKNavigationDelegate {
  static let shared = WebViewPreloader()

  private let scrollingSource: String?
  private let mathJaxSource: String?
  private let mermaidSource: String?
  private var warmupView: WKWebView?
  private var warmupStart: Date?

  private override init() {
    // Flutter assets live in App.framework, not Runner.app directly.
    let appFramework = Bundle.main.bundleURL.appendingPathComponent("Frameworks/App.framework")
    let base = appFramework

    func load(_ relativePath: String) -> String? {
      let url = base.appendingPathComponent(relativePath)
      do {
        return try String(contentsOf: url, encoding: .utf8)
      } catch {
        print("[WebViewPreloader] FAILED \(relativePath): \(error)")
        return nil
      }
    }

    scrollingSource = load("flutter_assets/assets/www/scripts/scrolling.js")

    // Fonts must live in applicationSupportDirectory — the WebView's allowingReadAccessTo root.
    // Copy once per app version so updates are picked up without manual cache busting.
    let mathJaxFontPath: String?
    if let appSupportDir = FileManager.default.urls(
      for: .applicationSupportDirectory, in: .userDomainMask
    ).first {
      let fontDest = appSupportDir.appendingPathComponent("mathjax-fonts")
      let fontSrc = base.appendingPathComponent("flutter_assets/assets/www/scripts/mathjax/fonts")
      WebViewPreloader.syncFonts(from: fontSrc, to: fontDest)
      mathJaxFontPath = fontDest.absoluteString + "/%%FONT%%-font"
    } else {
      mathJaxFontPath = nil
    }

    if let body = load("flutter_assets/assets/www/scripts/mathjax/tex-chtml.js"),
      let fontPath = mathJaxFontPath
    {
      // Config block must precede source so MathJax reads it on init.
      // fontPath uses %%FONT%% placeholder; MathJax v4 substitutes the font name (e.g. mathjax-newcm).
      mathJaxSource = """
        window.MathJax = {
          tex: { inlineMath: [['$', '$'], ['\\\\(', '\\\\)']] },
          output: { fontPath: '\(fontPath)' },
          startup: {
            ready() {
              const t0 = performance.now();
              MathJax.startup.defaultReady();
              console.log('[MathJax] ready in ' + Math.round(performance.now() - t0) + 'ms');
            }
          }
        };
        """ + body
    } else {
      mathJaxSource = nil
    }

    mermaidSource = load("flutter_assets/assets/www/scripts/mermaid/mermaid.min.js")

    super.init()

    print("[WebViewPreloader] scrollingSource loaded: \(scrollingSource != nil)")
    print("[WebViewPreloader] mathJaxSource loaded: \(mathJaxSource != nil)")
    print("[WebViewPreloader] mermaidSource loaded: \(mermaidSource != nil)")

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

    config.userContentController.addUserScript(
      WKUserScript(
        source: """
          window.ScrollProgress = webkit.messageHandlers.ScrollProgress;
          window.ScrollEnd = webkit.messageHandlers.ScrollEnd;
          """,
        injectionTime: .atDocumentStart, forMainFrameOnly: true
      ))
    config.userContentController.addUserScript(
      WKUserScript(
        source: """
          (function() {
            ['log','warn','error','info'].forEach(function(m) {
              var orig = console[m];
              console[m] = function() {
                window.webkit.messageHandlers.ConsoleLog
                  .postMessage('[' + m + '] ' + Array.from(arguments).join(' '));
                orig.apply(console, arguments);
              };
            });
          })();
          """,
        injectionTime: .atDocumentStart, forMainFrameOnly: true
      ))

    if let source = scrollingSource {
      // atDocumentEnd: needs DOM; matches the former <script> at end of body.
      config.userContentController.addUserScript(
        WKUserScript(
          source: "console.log('[WebViewPreloader] scrolling.js loaded');\n" + source,
          injectionTime: .atDocumentEnd, forMainFrameOnly: true))
    } else {
      print("[WebViewPreloader] scrolling.js NOT loaded — user script skipped")
    }

    if let source = mathJaxSource {
      // atDocumentEnd: MathJax appends to document.head at init time, so the DOM must exist.
      // The window.MathJax config is in the same script block, so it's still read first.
      config.userContentController.addUserScript(
        WKUserScript(
          source: "console.log('[WebViewPreloader] MathJax loaded');\n" + source,
          injectionTime: .atDocumentEnd, forMainFrameOnly: true))
    } else {
      print("[WebViewPreloader] MathJax NOT loaded — user script skipped")
    }

    if let source = mermaidSource {
      // atDocumentEnd: needs DOM to find <pre class="mermaid"> elements.
      // startOnLoad: false because DOMContentLoaded has already fired at this injection point.
      config.userContentController.addUserScript(
        WKUserScript(
          source: source + """
            \nmermaid.initialize({ startOnLoad: false, theme: window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'default' });
            mermaid.run();
            """,
          injectionTime: .atDocumentEnd, forMainFrameOnly: true))
    } else {
      print("[WebViewPreloader] Mermaid NOT loaded — user script skipped")
    }

    return config
  }

  // Update when running build-mathjax.sh with a new version.
  private static let mathJaxVersion = "4.1.1"

  private static func syncFonts(from source: URL, to dest: URL) {
    let versionFile = dest.appendingPathComponent(".version")
    if let installed = try? String(contentsOf: versionFile, encoding: .utf8),
      installed == mathJaxVersion
    {
      return
    }
    let fm = FileManager.default
    try? fm.removeItem(at: dest)
    do {
      try fm.copyItem(at: source, to: dest)
      try mathJaxVersion.write(to: versionFile, atomically: true, encoding: .utf8)
      print("[WebViewPreloader] fonts synced for MathJax \(mathJaxVersion)")
    } catch {
      print("[WebViewPreloader] fonts sync FAILED: \(error)")
    }
  }
}
