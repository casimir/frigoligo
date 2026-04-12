mermaid.initialize({
  startOnLoad: false,
  theme: window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'default',
});
mermaid.run();
