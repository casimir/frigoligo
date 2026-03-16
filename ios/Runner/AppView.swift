import SwiftUI

struct AppView: View {
  var body: some View {
    NavigationSplitView {
      Text("Articles")  // placeholder for Phase 1
    } detail: {
      Text("Select an article")
    }
  }
}
