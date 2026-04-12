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
}

class WebViewCustomScript {
  const WebViewCustomScript({
    required this.name,
    required this.file,
    required this.injectionTime,
  });

  final String name;
  final String file;
  final ScriptInjectionTime injectionTime;
}

const webViewNpmScripts = [
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
    name: 'webkit_init',
    file: 'webkit_init.js',
    injectionTime: ScriptInjectionTime.atDocumentStart,
  ),
  WebViewCustomScript(
    name: 'scrolling',
    file: 'scrolling.js',
    injectionTime: ScriptInjectionTime.atDocumentEnd,
  ),
];
