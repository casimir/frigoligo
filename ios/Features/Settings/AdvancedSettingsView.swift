import SwiftUI

struct AdvancedSettingsView: View {
  @EnvironmentObject var viewModel: SettingsViewModel

  private var settings: AppSettings { viewModel.appSettings }

  var body: some View {
    List {
      Section {
        LabeledContent(String(localized: "settings_itemInternetCheckUrl")) {
          TextField(
            "https://...",
            text: binding(\.internetCheckUrl, with: { $0.with(internetCheckUrl: $1) })
          )
          .keyboardType(.URL)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled()
          .multilineTextAlignment(.trailing)
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
