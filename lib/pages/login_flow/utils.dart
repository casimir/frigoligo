import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart' show Logger;

import '../../buildcontext_extension.dart';

final logger = Logger('login');

String? notEmptyValidator(BuildContext context, String? value, String label) =>
    value == null || value.isEmpty ? context.L.server_emptyField(label) : null;
