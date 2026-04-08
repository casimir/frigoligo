import SwiftUI

struct ServerCheckView: View {
  let dismissCover: () -> Void

  @EnvironmentObject var viewModel: LoginViewModel

  @State private var url = ""
  @State private var selfSigned = false
  @State private var isChecking = false
  @State private var error: String?
  @State private var checkResult: ServerCheckResult?
  @State private var showCredentials = false
  @FocusState private var urlFocused: Bool

  var body: some View {
    Form {
      Section {
        TextField("https://…", text: $url)
          .textContentType(.URL)
          .keyboardType(.URL)
          .autocorrectionDisabled()
          .textInputAutocapitalization(.never)
          .focused($urlFocused)
        Toggle(String(localized: "login_acceptSelfSigned"), isOn: $selfSigned)
      }

      if let error {
        Section {
          Text(error)
            .foregroundStyle(.red)
        }
      }

      Section {
        Button(String(localized: "login_demoMode")) {
          Task {
            await viewModel.loadDemoMode()
            dismissCover()
          }
        }
      }
    }
    .navigationTitle(String(localized: "g_server"))
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        if isChecking {
          ProgressView()
        } else {
          Button(String(localized: "g_check")) {
            Task { await check() }
          }
          .disabled(url.isEmpty)
        }
      }
    }
    .navigationDestination(isPresented: $showCredentials) {
      if let result = checkResult {
        CredentialsView(checkResult: result, onSuccess: dismissCover)
      }
    }
    .onAppear { urlFocused = true }
  }

  private func check() async {
    isChecking = true
    error = nil
    defer { isChecking = false }

    guard let result = await viewModel.checkServer(url: url, selfSigned: selfSigned) else {
      error = String(localized: "server_unreachable")
      return
    }

    if let kind = result.errorKind {
      error = errorMessage(for: kind, detail: result.errorMessage)
      return
    }

    checkResult = result
    showCredentials = true
  }

  private func errorMessage(for kind: String, detail: String?) -> String {
    switch kind {
    case "invalidUrl": return String(localized: "server_invalidUrl")
    case "unknownServerType": return String(localized: "server_unknownServerType")
    case "unreachable": return String(localized: "server_unreachable")
    case "versionNotSupported": return String(localized: "server_versionNotSupported")
    default: return detail ?? kind
    }
  }
}
