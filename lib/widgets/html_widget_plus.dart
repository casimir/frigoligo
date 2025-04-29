import 'package:cadanse/cadanse.dart';
import 'package:cadanse/tokens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_cached_network_image/fwfh_cached_network_image.dart';
import 'package:fwfh_url_launcher/fwfh_url_launcher.dart';

class HtmlWidgetFactory extends WidgetFactory
    with CachedNetworkImageFactory, UrlLauncherFactory {
  HtmlWidgetFactory({this.onTreeBuilt});

  void Function(Widget)? onTreeBuilt;

  @override
  Widget buildBodyWidget(BuildContext context, Widget child) {
    final body = super.buildBodyWidget(context, child);
    onTreeBuilt?.call(body);
    return body;
  }
}

class HtmlWidgetPlus extends StatelessWidget {
  const HtmlWidgetPlus(
    this.html, {
    super.key,
    this.title,
    this.onTreeBuilt,
    this.justifyText,
    this.textStyle,
  });

  final String html;
  final String? title;
  final void Function(Widget)? onTreeBuilt;
  final bool? justifyText;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    var style =
        'justify-content:center;'
        // 1 em ~ 2 characters (1 em is the width of 'M')
        'max-width:40em;';
    if (justifyText == true) style += 'text-align:justify;';

    final content =
        '<html>'
        '<body>'
        '  <div style="$style">$html</div>'
        '</body>'
        '</html>';

    final widget = HtmlWidget(
      content,
      factoryBuilder:
          () => HtmlWidgetFactory(
            onTreeBuilt:
                (child) => WidgetsBinding.instance.addPostFrameCallback((_) {
                  onTreeBuilt?.call(child);
                }),
          ),
      textStyle: textStyle,
    );

    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacingInGroup),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: textStyle?.copyWith(
                  fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              C.spacers.verticalComponent,
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [widget],
            ),
          ],
        ),
      ),
    );
  }
}
