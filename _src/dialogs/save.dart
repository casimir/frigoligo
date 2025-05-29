import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../buildcontext_extension.dart';

bool validateURL(String? value) {
  if (value == null || value.isEmpty) return false;

  try {
    return Uri.parse(value).isAbsolute;
  } on FormatException {
    return false;
  }
}

Future<void> showSaveUrlDialog(BuildContext context) async {
  final clipboard = await Clipboard.getData(Clipboard.kTextPlain);
  final initial = validateURL(clipboard?.text) ? clipboard!.text : null;

  if (!context.mounted) return;

  final values = await showTextInputDialog(
    context: context,
    title: context.L.save_title,
    textFields: [
      DialogTextField(
        initialText: initial,
        validator: (value) =>
            validateURL(value) ? null : context.L.server_invalidUrl,
        keyboardType: TextInputType.url,
        autocorrect: false,
      )
    ],
    autoSubmit: true,
  );
  if (values == null || values.isEmpty) return;

  final url = values[0].toString();
  if (!context.mounted) return;
  context.push('/save?url=$url');
}
