hljs.configure({cssSelector: 'pre code, pre[class*="language-"]'});
hljs.highlightAll();

(function () {
  function updateTheme() {
    var link = document.querySelector('link[href*="highlightjs/styles"]');
    if (!link) return;
    var isDark = document.documentElement.getAttribute('data-theme') === 'dark';
    console.log('[highlightjs] using theme: ' + (isDark ? 'dark' : 'light'));
    link.href = link.href.replace(/[\w-]+\.min\.css$/, isDark ? 'dark.min.css' : 'default.min.css');
  }

  new MutationObserver(updateTheme).observe(document.documentElement, {
    attributes: true, attributeFilter: ['data-theme'],
  });

  updateTheme();
})();