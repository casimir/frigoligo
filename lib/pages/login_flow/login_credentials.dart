import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../wallabag/utils.dart';

class LoginFlowCredentials extends ConsumerWidget {
  const LoginFlowCredentials({super.key, required this.serverCheck});

  final WallabagServerCheck serverCheck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text(serverCheck.toString()),
    );
  }
}
