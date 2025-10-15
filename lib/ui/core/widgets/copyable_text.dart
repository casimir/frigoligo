import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../buildcontext_extension.dart';

/// A text widget that allows to copy to the clipboard by tapping on it.
class CopyableText extends StatelessWidget {
  /// Create a new copyable text widget.
  ///
  /// The clipboard will be set to [text] or [value] if provided.
  ///
  /// A [SnackBar] will be shown to the user to confirm the copy.
  const CopyableText({super.key, required this.text, this.data});

  final Text text;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: text,
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: data ?? text.data!));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.L.session_copiedToClipboard)),
          );
        }
      },
    );
  }
}
