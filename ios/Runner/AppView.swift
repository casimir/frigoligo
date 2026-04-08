import SwiftUI

struct AppView: View {
  @EnvironmentObject var navigationViewModel: NavigationSplitViewModel
  @EnvironmentObject var authGateViewModel: AuthGateViewModel
  @EnvironmentObject var loginViewModel: LoginViewModel

  @State private var pendingLogin = false

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
      ),
      onDismiss: showLoginIfPending
    ) {
      SettingsView()
    }
    .fullScreenCover(
      isPresented: Binding(
        get: { navigationViewModel.showSettingsSheet && !isIPad },
        set: { navigationViewModel.showSettingsSheet = $0 }
      ),
      onDismiss: showLoginIfPending
    ) {
      SettingsView()
    }
    .fullScreenCover(isPresented: $authGateViewModel.requiresLogin) {
      LoginView()
        .environmentObject(loginViewModel)
    }
    .alert(
      String(localized: "session_renewDialogTitle"),
      isPresented: $authGateViewModel.showReauthAlert
    ) {
      Button(String(localized: "login_actionLogin")) {
        authGateViewModel.requiresLogin = true
      }
      Button("Later", role: .cancel) {}
    } message: {
      Text(String(localized: "session_renewDialogMessage"))
    }
    .onChange(of: authGateViewModel.requiresLogin) { isRequired in
      if isRequired && navigationViewModel.showSettingsSheet {
        pendingLogin = true
        authGateViewModel.requiresLogin = false
        navigationViewModel.showSettingsSheet = false
      }
    }
  }

  private func showLoginIfPending() {
    if pendingLogin {
      pendingLogin = false
      authGateViewModel.requiresLogin = true
    }
  }
}
