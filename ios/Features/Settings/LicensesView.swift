import SwiftUI

struct LicensesView: View {
  @EnvironmentObject var viewModel: LicensesViewModel

  var body: some View {
    List(viewModel.packages, id: \.name) { package in
      NavigationLink(package.name) {
        ScrollView {
          Text(package.body)
            .font(.system(.caption, design: .monospaced))
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle(package.name)
        .navigationBarTitleDisplayMode(.inline)
      }
    }
    .navigationTitle(String(localized: "settings_itemLicenses"))
    .task {
      await viewModel.loadIfNeeded()
    }
  }
}
