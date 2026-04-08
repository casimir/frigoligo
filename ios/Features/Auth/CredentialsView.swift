import SwiftUI

struct CredentialsView: View {
  let checkResult: ServerCheckResult
  let onSuccess: () -> Void

  @EnvironmentObject var viewModel: LoginViewModel

  @State private var clientId = ""
  @State private var clientSecret = ""
  @State private var username = ""
  @State private var password = ""
  @State private var apiToken = ""
  @State private var isLoggingIn = false
  @State private var error: String?
  @FocusState private var firstFieldFocused: Bool

  private var isWallabag: Bool { checkResult.serverType == "wallabag" }

  var body: some View {
    Form {
      if isWallabag {
        Section {
          TextField(String(localized: "login_fieldClientId"), text: $clientId)
            .focused($firstFieldFocused)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
          SecureField(String(localized: "login_fieldClientSecret"), text: $clientSecret)
          TextField(String(localized: "login_fieldUsername"), text: $username)
            .textContentType(.username)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
          SecureField(String(localized: "login_fieldPassword"), text: $password)
            .textContentType(.password)
        }
      } else {
        Section {
          TextField(String(localized: "session_fieldApiToken"), text: $apiToken)
            .focused($firstFieldFocused)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
        }
      }

      if let error {
        Section {
          Text(error)
            .foregroundStyle(.red)
          NavigationLink(String(localized: "login_openLogConsole")) {
            LogConsoleView()
          }
        }
      }
    }
    .navigationTitle(String(localized: "login_actionLogin"))
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        if isLoggingIn {
          ProgressView()
        } else {
          Button(String(localized: "login_actionLogin")) {
            Task { await login() }
          }
          .disabled(!canSubmit)
        }
      }
    }
    .onAppear { firstFieldFocused = true }
  }

  private var canSubmit: Bool {
    if isWallabag {
      return !clientId.isEmpty && !clientSecret.isEmpty
        && !username.isEmpty && !password.isEmpty
    } else {
      return !apiToken.isEmpty
    }
  }

  private func login() async {
    isLoggingIn = true
    error = nil
    defer { isLoggingIn = false }

    guard let url = checkResult.serverUrl else { return }
    let selfSigned = checkResult.selfSigned

    if isWallabag {
      error = await viewModel.loginWallabag(
        url: url, selfSigned: selfSigned,
        clientId: clientId, clientSecret: clientSecret,
        username: username, password: password
      )
    } else {
      error = await viewModel.loginFreon(url: url, selfSigned: selfSigned, token: apiToken)
    }

    if error == nil { onSuccess() }
  }
}
