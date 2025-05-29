import 'package:flutter/material.dart';

import '../../buildcontext_extension.dart';
import '../../server/check.dart';
import '../../server/session.dart';
import '../../wallabag/credentials.dart';
import '../../wallabag/wallabag.dart';
import '../../widget_keys.dart';
import 'login_credentials.dart';

class WallabagLoginFlowController implements LoginFlowController {
  @override
  bool dataIsExhaustive(Map<String, String> data) =>
      data.isNotEmpty &&
      data.containsKey('clientId') &&
      data.containsKey('clientSecret') &&
      data.containsKey('username') &&
      data.containsKey('password');

  @override
  List<LoginField> getFields(BuildContext context) => [
        LoginField(
          name: 'clientId',
          label: context.L.login_fieldClientId,
          icon: const Icon(Icons.key),
          key: const Key(wkLoginFlowClientId),
          autofocus: true,
        ),
        LoginField(
          name: 'clientSecret',
          label: context.L.login_fieldClientSecret,
          icon: const Icon(Icons.lock),
        ),
        LoginField(
          name: 'username',
          label: context.L.login_fieldUsername,
          icon: const Icon(Icons.person),
          autofillHints: const [AutofillHints.username],
        ),
        LoginField(
          name: 'password',
          label: context.L.login_fieldPassword,
          icon: const Icon(Icons.password),
          obscureText: true,
          autofillHints: const [AutofillHints.password],
        ),
      ];

  @override
  Future<ServerSession> openSession(
      ServerCheck check, Map<String, dynamic> values) async {
    final credentials =
        Credentials(check.uri!, values['clientId'], values['clientSecret']);
    final credsAdapter = InMemoryCredentials(credentials);
    final wallabag = WallabagNativeClient(credsAdapter);
    await wallabag.fetchToken(values['username'], values['password']);
    return ServerSession(
      ServerType.wallabag,
      useSelfSigned: check.selfSigned,
      wallabag: credsAdapter.credentials,
    );
  }
}
