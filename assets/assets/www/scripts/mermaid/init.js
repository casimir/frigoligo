(function () {
  var diagrams = document.querySelectorAll('.mermaid');
  var init = false;

  function currentTheme() {
    var themes = {
      'light': 'neutral',
      'dark': 'dark',
    };
    var current = document.documentElement.getAttribute('data-theme');
    return themes[current] ?? 'default';
  }

  async function render(theme) {
    console.log('[mermaid] using theme: ' + theme);
    mermaid.initialize({ startOnLoad: false, theme: theme });

    for (var diagram of diagrams) {
      if (!init) {
        // hardcoded theme can be present in the original content
        var src = diagram.textContent.replace(/^[ \t]+theme:[ \t]+\w+[ \t]*\n/m, '');
        diagram.setAttribute('data-diagram', src);
      }
      var def = diagram.getAttribute('data-diagram');
      var { svg } = await mermaid.render('mermaid-' + crypto.randomUUID(), def);
      diagram.innerHTML = svg;
    }
    init = true;
  }

  new MutationObserver(function () { render(currentTheme()); }).observe(document.documentElement, {
    attributes: true,
    attributeFilter: ['data-theme'],
  });

  render(currentTheme());
})();
