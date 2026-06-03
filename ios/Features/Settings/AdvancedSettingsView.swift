import SwiftUI

struct AdvancedSettingsView: View {
  @EnvironmentObject var viewModel: SettingsViewModel

  private var settings: AppSettings { viewModel.appSettings }

  var body: some View {
    List {
      Section {
        NavigationLink {
          InternetCheckUrlEditView(
            url: binding(\.internetCheckUrl, with: { $0.with(internetCheckUrl: $1) })
          )
        } label: {
          LabeledContent(String(localized: "settings_itemInternetCheckUrl")) {
            Text(settings.internetCheckUrl)
              .foregroundStyle(.secondary)
          }
        }
      }
    }
    .navigationTitle(String(localized: "settings_itemAdvanced"))
    .navigationBarTitleDisplayMode(.inline)
  }

  private func binding<T>(
    _ keyPath: KeyPath<AppSettings, T>,
    with update: @escaping (AppSettings, T) -> AppSettings
  ) -> Binding<T> {
    Binding(
      get: { settings[keyPath: keyPath] },
      set: { viewModel.setAppSettings(update(settings, $0)) }
    )
  }
}

private struct InternetCheckUrlEditView: View {
  @Binding var url: String

  var body: some View {
    Form {
      Section {
        TextField("https://...", text: $url)
          .keyboardType(.URL)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled()
      }
    }
    .navigationTitle(String(localized: "settings_itemInternetCheckUrl"))
    .navigationBarTitleDisplayMode(.inline)
  }
}
