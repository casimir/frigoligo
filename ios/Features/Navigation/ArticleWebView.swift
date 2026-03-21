import SwiftUI
import WebKit

struct ArticleWebView: UIViewRepresentable {
  let html: String
  let readingProgress: Double
  let onProgressChange: (Double) -> Void

  func makeCoordinator() -> Coordinator {
    Coordinator(readingProgress: readingProgress, onProgressChange: onProgressChange)
  }

  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    webView.navigationDelegate = context.coordinator
    webView.scrollView.delegate = context.coordinator
    context.coordinator.webView = webView
    webView.loadHTMLString(wrapFragment(html), baseURL: nil)
    return webView
  }

  func updateUIView(_ webView: WKWebView, context: Context) {}

  private func wrapFragment(_ fragment: String) -> String {
    """
    <!DOCTYPE html>
    <html>
    <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
      body {
        max-width: 680px;
        margin: 0 auto;
        padding: 16px;
        font-family: -apple-system, sans-serif;
        font-size: 17px;
        line-height: 1.6;
        color: #1c1c1e;
      }
      img { max-width: 100%; height: auto; }
      pre { overflow-x: auto; }
      @media (prefers-color-scheme: dark) {
        body { background: #000; color: #f2f2f7; }
      }
    </style>
    </head>
    <body>\(fragment)</body>
    </html>
    """
  }
}

extension ArticleWebView {
  class Coordinator: NSObject, WKNavigationDelegate, UIScrollViewDelegate {
    weak var webView: WKWebView?
    private let readingProgress: Double
    private let onProgressChange: (Double) -> Void
    private var progressDebounce: Timer?
    private var didRestoreScroll = false

    init(readingProgress: Double, onProgressChange: @escaping (Double) -> Void) {
      self.readingProgress = readingProgress
      self.onProgressChange = onProgressChange
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      guard !didRestoreScroll, readingProgress > 0 else { return }
      didRestoreScroll = true
      let contentHeight = webView.scrollView.contentSize.height
      let viewHeight = webView.scrollView.bounds.height
      let maxOffset = max(0, contentHeight - viewHeight)
      webView.scrollView.contentOffset = CGPoint(x: 0, y: readingProgress * maxOffset)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      progressDebounce?.invalidate()
      progressDebounce = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {
        [weak self] _ in
        guard let self else { return }
        let contentHeight = scrollView.contentSize.height
        let viewHeight = scrollView.bounds.height
        let maxOffset = max(1, contentHeight - viewHeight)
        self.onProgressChange(min(1, max(0, scrollView.contentOffset.y / maxOffset)))
      }
    }
  }
}
