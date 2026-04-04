import SwiftUI

struct SidebarView: View {
  @EnvironmentObject var viewModel: NavigationSplitViewModel
  @State private var searchText = ""

  var body: some View {
    List(selection: $viewModel.selectedArticleId) {
      Section {
        ForEach(viewModel.articleIds, id: \.self) { id in
          ArticleRowView(id: id)
            .tag(id)
        }
      } header: {
        FilterBarView()
          .textCase(nil)
          .background(.bar)
      }
    }
    .listStyle(.plain)
    .animation(.default, value: viewModel.articleIds)
    .refreshable { await viewModel.refresh() }
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
    .sheet(isPresented: $viewModel.showSaveLinkSheet) {
      SaveLinkView().environmentObject(viewModel)
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
