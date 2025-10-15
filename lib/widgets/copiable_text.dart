import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopiableText extends StatelessWidget {
  @Deprecated('Use the core version instead')
  const CopiableText(
    this.text, {
    super.key,
    this.copiable = true,
    this.value,
    this.onCopy,
  });

  final Text text;
  final bool copiable;
  final String? value;
  final void Function(String)? onCopy;

  String get data => value ?? text.data!;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: text,
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: data));
        onCopy?.call(data);
      },
    );
  }
}
