import SafariServices
import SwiftUI
import WebKit

struct ArticleWebView: UIViewRepresentable {
  let html: String
  let title: String?
  let readingProgress: Double
  let readingSettings: ArticleReadingSettings
  let onProgressChange: (Double) -> Void

  private var baseURL: URL? {
    FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(readingProgress: readingProgress, onProgressChange: onProgressChange)
  }

  func makeUIView(context: Context) -> WKWebView {
    let config = WKWebViewConfiguration()
    config.userContentController.add(context.coordinator, name: "ScrollProgress")
    config.userContentController.add(context.coordinator, name: "ScrollEnd")
    config.userContentController.add(context.coordinator, name: "ConsoleLog")
    config.userContentController.addUserScript(
      WKUserScript(
        source: """
            window.ScrollProgress = webkit.messageHandlers.ScrollProgress;
            window.ScrollEnd = webkit.messageHandlers.ScrollEnd;
          """,
        injectionTime: .atDocumentStart,
        forMainFrameOnly: true
      ))
    config.userContentController.addUserScript(
      WKUserScript(
        source: """
            (function() {
              ['log','warn','error','info'].forEach(function(m) {
                var orig = console[m];
                console[m] = function() {
                  window.webkit.messageHandlers.ConsoleLog.postMessage('[' + m + '] ' + Array.from(arguments).join(' '));
                  orig.apply(console, arguments);
                };
              });
            })();
          """,
        injectionTime: .atDocumentStart,
        forMainFrameOnly: true
      ))
    let webView = WKWebView(frame: .zero, configuration: config)
    webView.navigationDelegate = context.coordinator
    webView.backgroundColor = .systemBackground
    #if DEBUG
      if #available(iOS 16.4, *) { webView.isInspectable = true }
    #endif
    context.coordinator.webView = webView
    loadArticle(into: webView)
    return webView
  }

  static func dismantleUIView(_ webView: WKWebView, coordinator: Coordinator) {
    webView.configuration.userContentController.removeScriptMessageHandler(
      forName: "ScrollProgress")
    webView.configuration.userContentController.removeScriptMessageHandler(forName: "ScrollEnd")
    webView.configuration.userContentController.removeScriptMessageHandler(forName: "ConsoleLog")
  }

  func updateUIView(_ webView: WKWebView, context: Context) {
    if html != context.coordinator.lastHtml || readingSettings != context.coordinator.lastSettings {
      context.coordinator.lastHtml = html
      context.coordinator.lastSettings = readingSettings
      context.coordinator.didRestoreScroll = false
      loadArticle(into: webView)
    }
  }

  private func loadArticle(into webView: WKWebView) {
    guard let baseURL else { return }
    let fileURL = baseURL.appendingPathComponent("article.html")
    try? wrapFragment(html).write(to: fileURL, atomically: true, encoding: .utf8)
    webView.loadFileURL(fileURL, allowingReadAccessToURL: baseURL)
  }

  private func fontSizeCss(_ size: Double) -> String {
    switch size {
    case 12: return "x-small"
    case 14: return "small"
    case 18: return "large"
    case 20: return "x-large"
    default: return "medium"
    }
  }

  private func wrapFragment(_ fragment: String) -> String {
    let textAlign = readingSettings.justifyText ? "justify" : "start"
    return """
      <html>
      <head>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="stylesheet" href="styles/fonts.css" />
      <style>
        body {
          max-width: 680px;
          margin: 0 auto;
          padding: 16px;
          font-family: \(readingSettings.fontFamily), sans-serif;
          font-size: \(fontSizeCss(readingSettings.fontSize));
          line-height: 1.6;
          text-align: \(textAlign);
          color: #1c1c1e;
        }
        img { max-width: 100%; height: auto; }
        pre { overflow-x: auto; }
        @media (prefers-color-scheme: dark) {
          body { background: #000; color: #f2f2f7; }
        }
      </style>
      </head>
      <body>\(title.map { "<h1>\($0)</h1>" } ?? "")\(fragment)
      <script src="scripts/scrolling.js"></script>
      </body>
      </html>
      """
  }
}

extension ArticleWebView {
  class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
    weak var webView: WKWebView?
    private let readingProgress: Double
    private let onProgressChange: (Double) -> Void
    var didRestoreScroll = false
    var lastHtml: String?
    var lastSettings: ArticleReadingSettings?

    init(readingProgress: Double, onProgressChange: @escaping (Double) -> Void) {
      self.readingProgress = readingProgress
      self.onProgressChange = onProgressChange
    }

    func webView(
      _ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
      decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
      guard let url = navigationAction.request.url else { return decisionHandler(.allow) }
      if url.scheme == "about" || url.scheme == "file" || navigationAction.navigationType == .other
      {
        decisionHandler(.allow)
      } else {
        var responder: UIResponder? = webView
        while let r = responder {
          if let vc = r as? UIViewController {
            vc.present(SFSafariViewController(url: url), animated: true)
            break
          }
          responder = r.next
        }
        decisionHandler(.cancel)
      }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      guard !didRestoreScroll, readingProgress > 0 else { return }
      didRestoreScroll = true
      webView.evaluateJavaScript("scrollToProgress(\(readingProgress))")
    }

    func userContentController(
      _ userContentController: WKUserContentController, didReceive message: WKScriptMessage
    ) {
      switch message.name {
      case "ScrollEnd":
        guard let progress = message.body as? Double else { return }
        onProgressChange(progress)
      case "ConsoleLog":
        print("[WebView] \(message.body)")
      default:
        break
      }
    }
  }
}
