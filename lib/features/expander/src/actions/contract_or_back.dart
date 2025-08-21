import 'package:flutter/widgets.dart';

import '../providers/expander.dart';

class ContractOrBackAction extends Action {
  ContractOrBackAction(this.context, this.expander);

  final BuildContext context;
  final Expander? expander;

  @override
  void invoke(covariant Intent intent) {
    if (expander != null) {
      if (expander?.isExpanded == true) {
        expander!.toggle();
      }
    } else {
      final navigator = Navigator.of(context);
      if (navigator.canPop()) {
        navigator.pop();
      }
    }
  }
}
