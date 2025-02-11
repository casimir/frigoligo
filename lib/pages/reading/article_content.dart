import 'dart:convert';
import 'dart:io';

import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../buildcontext_extension.dart';
import '../../color_extension.dart';
import '../../db/database.dart';
import '../../db/models/article.drift.dart';
import '../../providers/article.dart';
import '../../providers/reading_settings.dart';
import '../../providers/settings.dart';
import '../../widgets/html_widget_plus.dart';

class ArticleContent extends ConsumerStatefulWidget {
  const ArticleContent({
    super.key,
    required this.article,
    required this.scrollKey,
  });

  final Article article;
  final GlobalKey<NestedScrollViewState> scrollKey;

  @override
  ConsumerState<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends ConsumerState<ArticleContent> {
  ScrollController get controller =>
      widget.scrollKey.currentState!.innerController;

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  Future<void> _scrollListener() async {
    final pixels = controller.position.pixels;
    final maxExtent = controller.position.maxScrollExtent;
    final double progress = (pixels / maxExtent).clamp(0, 1);
    // TODO implement throttling to avoid ~35 updates when scrolling to top
    await DB().articlesDao.saveScrollProgress(widget.article, progress);
  }

  // As of version 2.0 there seem to be a random issue with the correct scroll
  // position being restored. The offset is kind of correct so it should be ok
  // on a normal usage but it's not perfect.
  Future<void> _jumpToProgress() async {
    final scrollPosition =
        await ref.read(scrollPositionProvider(widget.article.id).future);
    final progress = scrollPosition?.progress;
    if (progress != null && progress > 0) {
      final pixels = progress * controller.position.maxScrollExtent;
      controller.jumpTo(pixels);
    }
  }

  @override
  Widget build(BuildContext context) {
    final useNativeRenderer = ref
        .watch(settingsProvider.select((it) => it[Sk.nativeArticleRenderer]));

    if (useNativeRenderer && UniversalPlatform.isIOS) {
      return WebViewArticleRenderer(
        article: widget.article,
        onBuilt: () => _jumpToProgress(),
      );
    }

    final settings = ref.watch(readingSettingsProvider);
    return SelectionArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PaddedGroup(
              child: HtmlWidgetPlus(
                widget.article.content!,
                onTreeBuilt: (_) => _jumpToProgress(),
                justifyText: settings.justifyText,
                textStyle: settings.textStyle,
              ),
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }
}

class ArticleContentEmpty extends StatelessWidget {
  const ArticleContentEmpty({
    super.key,
    required this.articleUrl,
  });

  final Uri articleUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.L.article_noContentFetched,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          C.spacers.verticalContent,
          ElevatedButton(
            onPressed: () => launchUrl(articleUrl),
            child: Text(context.L.article_openInBrowser),
          ),
        ],
      ),
    );
  }
}

class ArticleContentRenderer {
  static const assetsPrefix = 'assets/www';
  static const fontAssetsPrefix = 'assets/google_fonts';
  static final hackstacheVariableRe = RegExp(r'{{\s*(\w+)\s*}}');

  static late String? htmlTemplate;
  static late Directory rootDir;

  static Directory get fontDir => Directory('${rootDir.path}/fonts');

  static Future<void> preload() async {
    htmlTemplate = await rootBundle.loadString('assets/article.template.html');
    rootDir = await getApplicationSupportDirectory();

    final assets = await AssetManifest.loadFromAssetBundle(rootBundle);
    await Future.wait([
      _unpackAssets(assets),
      _unpackFonts(assets),
    ]);
  }

  static Future<void> _unpackAssets(AssetManifest assets) async {
    final assetFiles = assets
        .listAssets()
        .where((key) => key.startsWith(assetsPrefix))
        .toList();
    for (final key in assetFiles) {
      final bin = await rootBundle.load(key);
      final target = File(key.replaceFirst(assetsPrefix, rootDir.path));
      if (!target.parent.existsSync()) {
        target.parent.createSync(recursive: true);
      }
      target.writeAsBytesSync(bin.buffer.asUint8List());
    }
  }

  static Future<void> _unpackFonts(AssetManifest assets) async {
    final fontFiles = assets
        .listAssets()
        .where((key) => key.startsWith(fontAssetsPrefix))
        .toList();
    if (!fontDir.existsSync()) fontDir.createSync(recursive: true);
    for (final key in fontFiles) {
      final bin = await rootBundle.load(key);
      final target = key.replaceFirst(fontAssetsPrefix, fontDir.path);
      File(target).writeAsBytesSync(bin.buffer.asUint8List());
    }
  }

  ArticleContentRenderer({required this.article});

  final Article article;
  String? _rendered;

  void execute(ColorScheme colors, ReaderSettingsValues settings) {
    final context = {
      'articleClass': settings.justifyText ? 'justified' : '',
      'articleContent': article.content!,
      'colorScheme': colorSchemeCss(colors),
      'readingSettings': readingSettingsCss(settings),
    };
    _rendered = htmlTemplate!.replaceAllMapped(hackstacheVariableRe, (match) {
      final variable = match.group(1)?.trim();
      return context[variable] ?? match.group(0)!;
    });
  }

  String colorSchemeCss(ColorScheme colors) {
    return '''
  <style>
    body {
      background-color: ${colors.surface.toRgbHex()};
      color: ${colors.onSurface.toRgbHex()};
    }
  </style>'''
        .trim();
  }

  String readingSettingsCss(ReaderSettingsValues settings) {
    final fontSize = {
      12.0: 'x-small',
      14.0: 'small',
      16.0: 'medium',
      18.0: 'large',
      20.0: 'x-large'
    }[settings.fontSize];

    return '''
  <style>
    body {
      font-family: "${settings.fontFamily}";
    }

    #content {
      font-size: ${fontSize ?? 'medium'};
    }
  </style>'''
        .trim();
  }

  String get text => _rendered!;

  Future<void> writeTo(File fpath) => fpath.writeAsString(text);
}

class FlutterArticleRenderer extends StatelessWidget {
  const FlutterArticleRenderer({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class WebViewArticleRenderer extends ConsumerStatefulWidget {
  const WebViewArticleRenderer({
    super.key,
    required this.article,
    this.onBuilt,
  });

  final Article article;
  final VoidCallback? onBuilt;

  @override
  ConsumerState<WebViewArticleRenderer> createState() =>
      _WebViewArticleRendererState();
}

class _WebViewArticleRendererState
    extends ConsumerState<WebViewArticleRenderer> {
  late final ArticleContentRenderer _renderer;
  late final WebViewController _webViewController;
  double? _webViewContentHeight;

  @override
  void initState() {
    super.initState();

    _renderer = ArticleContentRenderer(article: widget.article);

    late final WebKitWebViewController platform;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      platform = WebKitWebViewController(WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
      ));
      platform.setInspectable(kDebugMode);
    } else {
      // unreachable until Android is implemented
    }

    // TODO add config for iOS and Android (see controller doc)
    _webViewController = WebViewController.fromPlatform(platform)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) async {
          final url = Uri.tryParse(request.url);
          if (request.url == 'about:blank' || url?.scheme == 'file') {
            return NavigationDecision.navigate;
          }

          if (url != null && await canLaunchUrl(url)) {
            launchUrl(url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onPageFinished: (url) async {
          if (_webViewContentHeight != null) return;

          final result = await _webViewController.runJavaScriptReturningResult(
              'document.documentElement.scrollHeight');
          if (mounted) {
            setState(() {
              _webViewContentHeight = result as double;
            });
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onBuilt?.call();
            });
          }
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(readingSettingsProvider);

    final index = File('${ArticleContentRenderer.rootDir.path}/index.html');
    _renderer
      ..execute(Theme.of(context).colorScheme, settings)
      ..writeTo(index);

    _webViewController
      ..setBackgroundColor(Theme.of(context).colorScheme.surface)
      ..loadFile(index.path);

    final webView = WebViewWidget(controller: _webViewController);
    return _webViewContentHeight != null
        ? SingleChildScrollView(
            child: SizedBox(
              height: _webViewContentHeight,
              child: webView,
            ),
          )
        : webView;
  }
}
