import SwiftUI

enum SettingsCategory: String, CaseIterable, Identifiable {
  case session, logs

  var id: String { rawValue }

  var title: String {
    switch self {
    case .session: String(localized: "settings_itemSessionDetails")
    case .logs: String(localized: "settings_itemLogConsole")
    }
  }

  var icon: String {
    switch self {
    case .session: "person.crop.circle"
    case .logs: "doc.text.magnifyingglass"
    }
  }
}

struct SettingsView: View {
  @EnvironmentObject var viewModel: SettingsViewModel
  @State private var showClearCacheConfirm = false

  private var settings: AppSettings { viewModel.appSettings }

  var body: some View {
    NavigationStack {
      List {
        Section {
          Toggle(
            String(localized: "settings_itemAppBadge"),
            isOn: Binding(
              get: { settings.appBadge },
              set: { viewModel.setAppSettings(settings.with(appBadge: $0)) }
            )
          )
          Toggle(
            String(localized: "settings_savedArticleTag"),
            isOn: Binding(
              get: { settings.tagSaveEnabled },
              set: { viewModel.setAppSettings(settings.with(tagSaveEnabled: $0)) }
            )
          )
          TextField(
            String(localized: "settings_savedArticleTagLabel"),
            text: Binding(
              get: { settings.tagSaveLabel },
              set: { viewModel.setAppSettings(settings.with(tagSaveLabel: $0)) }
            )
          )
          .disabled(!settings.tagSaveEnabled)
        }

        Section {
          ForEach(SettingsCategory.allCases) { category in
            NavigationLink(value: category) {
              Label(category.title, systemImage: category.icon)
            }
          }
          Button(String(localized: "settings_itemClearCache")) {
            showClearCacheConfirm = true
          }
        }

        Section {
          Link(destination: URL(string: "https://github.com/casimir/frigoligo")!) {
            Label(
              String(localized: "g_sourceCode"),
              systemImage: "chevron.left.forwardslash.chevron.right")
          }
          Link(destination: URL(string: "https://github.com/casimir/frigoligo/issues")!) {
            Label(String(localized: "settings_bugReportLink"), systemImage: "ant")
          }
          Link(destination: URL(string: "https://hosted.weblate.org/projects/frigoligo/")!) {
            Label(String(localized: "settings_helpToTranslate"), systemImage: "globe")
          }
        }

        Section {
        } footer: {
          Text("Frigoligo \(appVersion)")
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
        }
      }
      .navigationTitle(String(localized: "g_settings"))
      .navigationDestination(for: SettingsCategory.self) { cat in
        switch cat {
        case .session: SessionDetailsView()
        case .logs: LogConsoleView()
        }
      }
      .alert(
        String(localized: "settings_itemClearCache"),
        isPresented: $showClearCacheConfirm
      ) {
        Button(String(localized: "settings_itemClearCache"), role: .destructive) {
          viewModel.clearCache()
        }
        Button("Cancel", role: .cancel) {}
      } message: {
        Text(String(localized: "settings_clearCacheMessage"))
      }
    }
  }

  private var appVersion: String {
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "—"
    let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "—"
    return "\(version) (\(build))"
  }
}

extension AppSettings {
  fileprivate func with(
    appBadge: Bool? = nil,
    tagSaveEnabled: Bool? = nil,
    tagSaveLabel: String? = nil
  ) -> AppSettings {
    AppSettings(
      appBadge: appBadge ?? self.appBadge,
      tagSaveEnabled: tagSaveEnabled ?? self.tagSaveEnabled,
      tagSaveLabel: tagSaveLabel ?? self.tagSaveLabel
    )
  }
}
