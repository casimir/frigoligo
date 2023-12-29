import 'package:flutter/widgets.dart';

import '../../buildcontext_extension.dart';

String? notEmptyValidator(BuildContext context, String? value, String label) =>
    value == null || value.isEmpty ? context.L.server_emptyField(label) : null;
