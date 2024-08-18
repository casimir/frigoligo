//
//  Credentials.swift
//  share
//
//  Created by Martin Chaine on 06/09/2023.
//

import Foundation

struct ServerSession : Codable {
    var type: String
    var wallabag: WallabagCredentials?
    var freon: FreonCredentials?
}

struct WallabagCredentials : Codable {
    var server: URL
    var clientId: String
    var clientSecret: String
    var token: TokenData
}

struct TokenData : Codable {
    var accessToken: String
    var expiresAt: Int
    var refreshToken: String
}

struct OAuthTokenBody : Codable {
    var access_token: String
    var expires_in: Int
    var refresh_token: String
}

func buildTokenData(_ source: OAuthTokenBody) -> TokenData {
    return TokenData(
        accessToken: source.access_token,
        expiresAt: Int(Date.now.timeIntervalSince1970) + source.expires_in,
        refreshToken: source.refresh_token
    )
}

struct FreonCredentials : Codable {
    var server: URL
    var apiToken: String
}
