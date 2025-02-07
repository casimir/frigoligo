import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/layouts/grouping.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  static String? htmlTemplate;
  static final hackstacheVariableRe = RegExp(r'{{\s*(\w+)\s*}}');

  static Future<void> preload() async {
    htmlTemplate = await rootBundle.loadString('assets/article.template.html');
  }

  const ArticleContentRenderer({required this.article});

  final Article article;

  String execute(ColorScheme colors, ReaderSettingsValues settings) {
    final context = {
      'articleClass': settings.justifyText ? 'justified' : '',
      'articleContent': article.content!,
      'colorScheme': colorSchemeCss(colors),
      'readingSettings': readingSettingsCss(settings),
    };
    return htmlTemplate!.replaceAllMapped(hackstacheVariableRe, (match) {
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
    #content {
      font-family: "Gill Sans";
      font-size: ${fontSize ?? 'medium'};
    }
  </style>'''
        .trim();
  }
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

    // TODO add config for iOS and Android (see controller doc)
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) async {
          final url = Uri.tryParse(request.url);
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
    final html = _renderer.execute(Theme.of(context).colorScheme, settings);

    _webViewController
      ..setBackgroundColor(Theme.of(context).colorScheme.surface)
      ..loadHtmlString(html);

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
