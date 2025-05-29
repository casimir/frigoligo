import 'package:json_annotation/json_annotation.dart';

part 'credentials.g.dart';

@JsonSerializable()
class Credentials {
  Credentials(this.server, this.clientId, this.clientSecret, {this.token});

  final Uri server;
  final String clientId;
  final String clientSecret;
  OAuthToken? token;

  factory Credentials.fromJson(Map<String, dynamic> json) =>
      _$CredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}

@JsonSerializable()
class OAuthToken {
  OAuthToken(this.accessToken, this.expiresAt, this.refreshToken);

  final String accessToken;
  final int expiresAt;
  final String refreshToken;

  DateTime get expirationDateTime =>
      DateTime.fromMillisecondsSinceEpoch(expiresAt * 1000);
  bool get isExpired => expirationDateTime.isBefore(DateTime.now());

  factory OAuthToken.fromJson(Map<String, dynamic> json) =>
      _$OAuthTokenFromJson(json);
  Map<String, dynamic> toJson() => _$OAuthTokenToJson(this);
}

abstract class UpdatableCredentialsAdapter {
  Future<Credentials?> read();
  Future<void> write(Credentials credentials);
}

class InMemoryCredentials extends UpdatableCredentialsAdapter {
  InMemoryCredentials(this._credentials);

  Credentials? _credentials;
  Credentials? get credentials => _credentials;

  @override
  Future<Credentials?> read() async => _credentials;

  @override
  Future<void> write(Credentials credentials) async {
    _credentials = credentials;
  }
}
