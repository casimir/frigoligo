import SwiftUI

private let isoFormatter = ISO8601DateFormatter()

struct SessionDetailsView: View {
  @EnvironmentObject var viewModel: SessionDetailsViewModel
  @State private var sessionData: SessionData?
  @State private var showLogoutConfirm = false

  var body: some View {
    Form {
      if let data = sessionData {
        sessionFields(data)
        actionsSection(data)
      } else {
        ProgressView()
          .frame(maxWidth: .infinity)
      }
    }
    .navigationTitle(String(localized: "session_title"))
    .task {
      sessionData = await viewModel.getSessionData()
    }
    .alert(
      String(localized: "session_logoutDialogTitle"),
      isPresented: $showLogoutConfirm
    ) {
      Button(String(localized: "session_logoutDialogConfirm"), role: .destructive) {
        viewModel.logout()
      }
      Button("Cancel", role: .cancel) {}
    } message: {
      Text(String(localized: "session_logoutDialogMessage"))
    }
  }

  @ViewBuilder
  private func sessionFields(_ data: SessionData) -> some View {
    Section {
      CopyableLabeledContent(String(localized: "g_server"), value: data.serverUrl)
    }

    if data.serverType == "freon", let token = data.apiToken {
      Section {
        CopyableLabeledContent(
          String(localized: "session_fieldApiToken"),
          value: obfuscated(token)
        )
      }
    }

    if data.serverType == "wallabag" {
      Section {
        if let clientId = data.clientId {
          CopyableLabeledContent("Client ID", value: obfuscated(clientId))
        }
        if let clientSecret = data.clientSecret {
          CopyableLabeledContent("Client secret", value: obfuscated(clientSecret))
        }
        if let accessToken = data.accessToken {
          CopyableLabeledContent(
            String(localized: "session_fieldAccessToken"),
            value: obfuscated(accessToken)
          )
        }
        if let expiration = data.tokenExpiration,
          let date = isoFormatter.date(from: expiration)
        {
          LabeledContent(String(localized: "session_fieldTokenExpiration")) {
            Text(date, format: .relative(presentation: .named))
          }
        }
      }
    }

    Section {
      LabeledContent(String(localized: "session_fieldLastServerSync")) {
        if let ts = data.lastSyncTimestamp {
          let date = Date(timeIntervalSince1970: Double(ts))
          Text(date, format: .relative(presentation: .named))
        } else {
          Text(String(localized: "session_neverSynced"))
            .foregroundStyle(.secondary)
        }
      }
    }
  }

  @ViewBuilder
  private func actionsSection(_ data: SessionData) -> some View {
    Section {
      if data.serverType == "wallabag" {
        Button(String(localized: "session_forceTokenResfresh")) {
          viewModel.refreshToken()
        }
      }
      Button(String(localized: "session_logoutSession"), role: .destructive) {
        showLogoutConfirm = true
      }
    }
  }

  private func obfuscated(_ value: String) -> String {
    guard value.count > 16 else { return value }
    return "\(value.prefix(8))...\(value.suffix(8))"
  }
}

private struct CopyableLabeledContent: View {
  let label: String
  let value: String

  init(_ label: String, value: String) {
    self.label = label
    self.value = value
  }

  var body: some View {
    LabeledContent(label, value: value)
      .contextMenu {
        Button {
          UIPasteboard.general.string = value
        } label: {
          Label(String(localized: "session_copiedToClipboard"), systemImage: "doc.on.doc")
        }
      }
  }
}
