import 'package:flutter/material.dart';

import '../../buildcontext_extension.dart';
import '../../server/check.dart';
import '../../server/clients.dart';
import '../../server/session.dart';
import 'login_credentials.dart';

class FreonLoginFlowController implements LoginFlowController {
  @override
  bool dataIsExhaustive(Map<String, String> data) =>
      data.isNotEmpty && data.containsKey('apiToken');

  @override
  List<LoginField> getFields(BuildContext context) => [
    LoginField(
      name: 'apiToken',
      label: context.L.session_fieldApiToken,
      icon: const Icon(Icons.token),
      autofocus: true,
    ),
  ];

  @override
  Future<ServerSession> openSession(
    ServerCheck check,
    Map<String, dynamic> values,
  ) async {
    final session = ServerSession(
      ServerType.freon,
      useSelfSigned: check.selfSigned,
      freon: TokenBearerCredentials(check.uri!, values['apiToken']),
    );
    final freon = FreonClient(session.freon!);
    await freon.getInfo();
    return session;
  }
}
