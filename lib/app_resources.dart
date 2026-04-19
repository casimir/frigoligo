import 'package:flutter/widgets.dart';

class AppResources extends InheritedWidget {
  const AppResources({super.key, required super.child});

  // TODO add branding colors
  // TODO add Icons
  // TODO add wordings (?)

  @override
  bool updateShouldNotify(AppResources oldWidget) => false;
}
