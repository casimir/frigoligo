import 'package:flutter/widgets.dart';
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
    var style = '';
    if (justifyText == true) style += 'text-align:justify;';
    // 1 em ~ 2 characters (1 em is the width of 'M')
    style += 'max-width:40em;';

    final prefix = title != null ? '<h1>$title</h1>' : '';

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: HtmlWidget(
        '$prefix<div style="$style">$html</div>',
        factoryBuilder: () => HtmlWidgetFactory(
          onTreeBuilt: (child) =>
              WidgetsBinding.instance.addPostFrameCallback((_) {
            onTreeBuilt?.call(child);
          }),
        ),
        textStyle: textStyle,
      ),
    );
  }
}
