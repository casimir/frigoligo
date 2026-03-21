import SwiftUI

struct SidebarView: View {
  @EnvironmentObject var viewModel: NavigationSplitViewModel
  @State private var searchText = ""

  var body: some View {
    VStack(spacing: 0) {
      FilterBarView()
      List(viewModel.articleIds, id: \.self, selection: $viewModel.selectedArticleId) { id in
        ArticleRowView(id: id)
          .tag(id)
      }
      .listStyle(.plain)
      .refreshable { await viewModel.refresh() }
    }
    .searchable(text: $searchText)
    .onChange(of: searchText) { newValue in
      viewModel.setSearchText(newValue)
    }
    .onAppear {
      searchText = viewModel.filterState.text
    }
    .onChange(of: viewModel.filterState.text) { newValue in
      if newValue != searchText {
        searchText = newValue
      }
    }
    .navigationTitle("Articles")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          viewModel.openSaveLink()
        } label: {
          Image(systemName: "plus")
        }
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          viewModel.openSettings()
        } label: {
          Image(systemName: "gear")
        }
      }
    }
  }
}
