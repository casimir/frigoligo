// %%FONT_PATH%% is substituted at runtime with the platform-specific font dir.
// MathJax then replaces %%FONT%% internally with the font name (e.g. mathjax-newcm).
window.MathJax = {
  tex: { inlineMath: [['$', '$'], ['\\(', '\\)']] },
  output: { fontPath: '%%FONT_PATH%%' },
  startup: {
    ready() {
      const t0 = performance.now();
      MathJax.startup.defaultReady();
      console.log('[MathJax] ready in ' + Math.round(performance.now() - t0) + 'ms');
    },
  },
};
