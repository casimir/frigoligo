import SwiftUI

struct LoginView: View {
  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject var viewModel: LoginViewModel

  var body: some View {
    NavigationStack {
      ServerCheckView(dismissCover: { dismiss() })
    }
  }
}
