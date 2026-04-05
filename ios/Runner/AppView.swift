import SwiftUI

struct AppView: View {
  @EnvironmentObject var navigationViewModel: NavigationSplitViewModel

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
  }
}
