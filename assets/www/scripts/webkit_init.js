if (window.webkit?.messageHandlers) {
  window.ScrollProgress = webkit.messageHandlers.ScrollProgress;
  window.ScrollEnd = webkit.messageHandlers.ScrollEnd;
}

if (window.webkit?.messageHandlers?.ConsoleLog) {
  (function () {
    ['log', 'warn', 'error', 'info'].forEach(function (m) {
      var orig = console[m];
      console[m] = function () {
        webkit.messageHandlers.ConsoleLog.postMessage(
          '[' + m + '] ' + Array.from(arguments).join(' '),
        );
        orig.apply(console, arguments);
      };
    });
  })();
}
