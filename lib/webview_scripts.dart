enum ScriptInjectionTime { atDocumentStart, atDocumentEnd }

class WebViewNpmScript {
  const WebViewNpmScript({
    required this.name,
    required this.npmPackage,
    required this.version,
    required this.files,
    this.extraNpmPackages,
    this.licensePath,
    this.preScriptFile,
    this.postScriptFile,
    required this.injectionTime,
    this.copyToFS,
  });

  final String name;
  final String npmPackage;
  final String version;
  final Map<String, String> files;
  final List<String>? extraNpmPackages;
  final String? licensePath;
  final String? preScriptFile;
  final String? postScriptFile;
  final ScriptInjectionTime injectionTime;
  final List<String>? copyToFS;
}

class WebViewCustomScript {
  const WebViewCustomScript({
    required this.name,
    required this.file,
    required this.injectionTime,
    this.copyToFS,
  });

  final String name;
  final String file;
  final ScriptInjectionTime injectionTime;
  final List<String>? copyToFS;
}

const webViewNpmScripts = [
  WebViewNpmScript(
    name: 'highlightjs',
    npmPackage: '@highlightjs/cdn-assets',
    version: '11.11.1', // renovate: datasource=npm depName=highlightjs
    files: {
      '@highlightjs/cdn-assets/highlight.min.js': 'highlight.min.js',
      '@highlightjs/cdn-assets/styles/default.min.css':
          'styles/default.min.css',
      '@highlightjs/cdn-assets/styles/dark.min.css': 'styles/dark.min.css',
      '@highlightjs/cdn-assets/LICENSE': 'LICENSE.txt',
    },
    licensePath: 'assets/www/scripts/highlightjs/LICENSE.txt',
    postScriptFile: 'init.js',
    injectionTime: ScriptInjectionTime.atDocumentEnd,
  ),
  WebViewNpmScript(
    name: 'mathjax',
    npmPackage: 'mathjax',
    version: '4.1.1', // renovate: datasource=npm depName=mathjax
    files: {
      'mathjax/tex-chtml.js': 'tex-chtml.js',
      '@mathjax/mathjax-newcm-font/chtml': 'fonts/mathjax-newcm-font/chtml',
      'mathjax/LICENSE': 'LICENSE.txt',
    },
    extraNpmPackages: ['@mathjax/mathjax-newcm-font'],
    licensePath: 'assets/www/scripts/mathjax/LICENSE.txt',
    preScriptFile: 'config.js',
    injectionTime: ScriptInjectionTime.atDocumentEnd,
    copyToFS: ['scripts/mathjax/fonts/mathjax-newcm-font/chtml'],
  ),
  WebViewNpmScript(
    name: 'mermaid',
    npmPackage: 'mermaid',
    version: '11.4.1', // renovate: datasource=npm depName=mermaid
    files: {
      'mermaid/dist/mermaid.min.js': 'mermaid.min.js',
      'mermaid/LICENSE': 'LICENSE.txt',
    },
    licensePath: 'assets/www/scripts/mermaid/LICENSE.txt',
    postScriptFile: 'init.js',
    injectionTime: ScriptInjectionTime.atDocumentEnd,
  ),
];

const webViewCustomScripts = [
  WebViewCustomScript(
    name: 'base',
    file: 'styles/base.css',
    copyToFS: ['styles/base.css'],
    injectionTime: ScriptInjectionTime.atDocumentStart,
  ),
  WebViewCustomScript(
    name: 'fonts',
    file: 'styles/fonts.css',
    copyToFS: ['styles/fonts.css', 'fonts'],
    injectionTime: ScriptInjectionTime.atDocumentStart,
  ),
  WebViewCustomScript(
    name: 'highlightjs_theme',
    file: 'scripts/highlightjs/styles/default.min.css',
    copyToFS: [
      'scripts/highlightjs/styles/default.min.css',
      'scripts/highlightjs/styles/dark.min.css',
    ],
    injectionTime: ScriptInjectionTime.atDocumentStart,
  ),
  WebViewCustomScript(
    name: 'webkit_init',
    file: 'scripts/webkit_init.js',
    injectionTime: ScriptInjectionTime.atDocumentStart,
  ),
  WebViewCustomScript(
    name: 'scrolling',
    file: 'scripts/scrolling.js',
    injectionTime: ScriptInjectionTime.atDocumentEnd,
  ),
];
