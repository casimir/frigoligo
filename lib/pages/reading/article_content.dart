import 'dart:convert';
import 'dart:io';

import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../buildcontext_extension.dart';
import '../../color_extension.dart';
import '../../constants.dart';
import '../../db/database.dart';
import '../../db/models/article.drift.dart';
import '../../providers/article.dart';
import '../../providers/reading_settings.dart';
import '../../providers/settings.dart';
import '../../widgets/html_widget_plus.dart';

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

typedef ProgressCallback = Future<void> Function(
    double progress, bool isScrolling);
typedef ProgressScrollTo = Future<void> Function(double pixels);
typedef ProgressScroller = Future<void> Function(ProgressScrollTo);

class ArticleContent extends ConsumerStatefulWidget {
  const ArticleContent({super.key, required this.article});

  final Article article;

  @override
  ConsumerState<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends ConsumerState<ArticleContent> {
  Future<void> _onScrollReady(ProgressScrollTo scrollTo) async {
    final scrollPosition =
        await ref.read(scrollPositionProvider(widget.article.id).future);
    final progress = scrollPosition?.progress;
    if (progress != null && progress > 0) {
      await scrollTo(progress);
    }
  }

  Future<void> _onScroll(double progress, bool isScrolling) async {
    ref.read(currentReadingProgressProvider.notifier).progress = progress;

    if (!isScrolling) {
      await DB().articlesDao.saveScrollProgress(widget.article, progress);
    }
  }

  @override
  Widget build(BuildContext context) {
    final useNativeRenderer =
        ref.read(settingsProvider)[Sk.nativeArticleRenderer];
    return nativeArticleRendererSupported && useNativeRenderer
        ? _WebViewContent(
            article: widget.article,
            onReadyToScroll: _onScrollReady,
            onScrollUpdate: _onScroll,
          )
        : _HtmlWidgetContent(
            article: widget.article,
            onScrollReady: _onScrollReady,
            onScroll: _onScroll,
          );
  }
}

class _HtmlWidgetContent extends ConsumerWidget {
  const _HtmlWidgetContent({
    required this.article,
    required this.onScrollReady,
    required this.onScroll,
  });

  final Article article;
  final ProgressScroller onScrollReady;
  final ProgressCallback onScroll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(readingSettingsProvider);
    return SelectionArea(
      child: NotificationListener<ScrollNotification>(
        onNotification: _onScrollNotification,
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              PaddedGroup(
                child: HtmlWidgetPlus(
                  article.content!,
                  title: article.title,
                  onTreeBuilt: (_) => onScrollReady((progress) async {
                    final controller = PrimaryScrollController.of(context);
                    final pixels =
                        progress * controller.position.maxScrollExtent;
                    controller.jumpTo(pixels);
                  }),
                  justifyText: settings.justifyText,
                  textStyle: settings.textStyle,
                ),
              ),
              SizedBox(height: MediaQuery.paddingOf(context).bottom),
            ],
          ),
        ),
      ),
    );
  }

  bool _onScrollNotification(ScrollNotification notification) {
    var update = false;
    var isScrolling = false;
    if (notification is ScrollUpdateNotification) {
      update = true;
      isScrolling = true;
    }
    if (notification is ScrollEndNotification) {
      update = true;
    }

    if (update) {
      final pixels = notification.metrics.pixels;
      final maxExtent = notification.metrics.maxScrollExtent;
      final double progress = (pixels / maxExtent).clamp(0, 1);
      onScroll(progress, isScrolling);
    }

    return false;
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
      'articleTitle': const HtmlEscape().convert(article.title),
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

class _WebViewContent extends ConsumerStatefulWidget {
  const _WebViewContent({
    required this.article,
    this.onReadyToScroll,
    this.onScrollUpdate,
  });

  final Article article;
  final ProgressScroller? onReadyToScroll;
  final ProgressCallback? onScrollUpdate;

  @override
  ConsumerState<_WebViewContent> createState() =>
      _WebViewArticleRendererState();
}

class _WebViewArticleRendererState extends ConsumerState<_WebViewContent> {
  static final log = Logger('webview');

  late final ArticleContentRenderer _renderer;
  late final WebViewController _webViewController;

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
      ..setOnConsoleMessage((message) => log.info(message.message))
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
          widget.onReadyToScroll?.call((progress) =>
              _webViewController.runJavaScript('scrollToProgress($progress)'));
        },
      ))
      ..addJavaScriptChannel('ScrollProgress', onMessageReceived: (message) {
        final progress = double.parse(message.message);
        widget.onScrollUpdate?.call(progress, true);
      })
      ..addJavaScriptChannel('ScrollEnd', onMessageReceived: (message) {
        final progress = double.parse(message.message);
        widget.onScrollUpdate?.call(progress, false);
      });
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

    return WebViewWidget(controller: _webViewController);
  }
}
