import SwiftUI

struct AppView: View {
  @EnvironmentObject var navigationViewModel: NavigationSplitViewModel

  private var isIPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }

  var body: some View {
    NavigationSplitView {
      SidebarView()
    } detail: {
      if navigationViewModel.selectedArticleId != nil {
        ArticleDetailView()
      } else {
        ArticleDetailPlaceholder()
      }
    }
    .sheet(
      isPresented: Binding(
        get: { navigationViewModel.showSettingsSheet && isIPad },
        set: { navigationViewModel.showSettingsSheet = $0 }
      )
    ) {
      SettingsView()
    }
    .fullScreenCover(
      isPresented: Binding(
        get: { navigationViewModel.showSettingsSheet && !isIPad },
        set: { navigationViewModel.showSettingsSheet = $0 }
      )
    ) {
      SettingsView()
    }
  }
}
