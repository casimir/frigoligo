import Foundation

extension AppSettings {
  func with(
    appBadge: Bool? = nil,
    internetCheckUrl: String? = nil,
    tagSaveEnabled: Bool? = nil,
    tagSaveLabel: String? = nil
  ) -> AppSettings {
    AppSettings(
      appBadge: appBadge ?? self.appBadge,
      internetCheckUrl: internetCheckUrl ?? self.internetCheckUrl,
      tagSaveEnabled: tagSaveEnabled ?? self.tagSaveEnabled,
      tagSaveLabel: tagSaveLabel ?? self.tagSaveLabel
    )
  }
}
