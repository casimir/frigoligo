window.MathJax = {
  tex: { inlineMath: [['$', '$'], ['\\(', '\\)']] },
  output: { fontPath: 'scripts/mathjax/fonts/%%FONT%%-font' },
  startup: {
    ready() {
      const t0 = performance.now();
      MathJax.startup.defaultReady();
      console.log('[MathJax] ready in ' + Math.round(performance.now() - t0) + 'ms');
    },
  },
};
