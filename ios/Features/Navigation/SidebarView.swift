import Flutter
import SwiftUI

struct SidebarView: View {
  @EnvironmentObject var viewModel: NavigationSplitViewModel
  @State private var searchText = ""
  @State private var searchScope: NavigationSearchTextMode = .all

  var body: some View {
    List(selection: $viewModel.selectedArticleId) {
      FilterBarView()
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
      ForEach(viewModel.articleIds, id: \.self) { id in
        ArticleRowView(id: id)
          .tag(id)
      }
    }
    .listStyle(.plain)
    .animation(.default, value: viewModel.articleIds)
    .refreshable { await viewModel.refresh() }
    .searchable(
      text: $searchText,
      placement: .automatic,
      prompt: String(localized: "filters_searchbarHint")
    )
    .searchScopes($searchScope) {
      Text(String(localized: "filters_searchModeAll")).tag(NavigationSearchTextMode.all)
      Text(String(localized: "filters_searchModeTitle")).tag(NavigationSearchTextMode.title)
      Text(String(localized: "filters_searchModeContent")).tag(NavigationSearchTextMode.content)
    }
    .onChange(of: searchText) { newValue in
      viewModel.setSearchText(newValue)
    }
    .onChange(of: searchScope) { newValue in
      viewModel.setTextMode(newValue)
    }
    .onAppear {
      searchText = viewModel.filterState.text
      searchScope = viewModel.filterState.textMode
    }
    .onChange(of: viewModel.filterState.text) { newValue in
      if newValue != searchText { searchText = newValue }
    }
    .onChange(of: viewModel.filterState.textMode) { newValue in
      if newValue != searchScope { searchScope = newValue }
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

private class PreviewBinaryMessenger: NSObject, FlutterBinaryMessenger {
  func send(onChannel channel: String, message: Data?) {}
  func send(onChannel channel: String, message: Data?, binaryReply callback: FlutterBinaryReply?) {}
  func setMessageHandlerOnChannel(
    _ channel: String, binaryMessageHandler handler: FlutterBinaryMessageHandler?
  ) -> FlutterBinaryMessengerConnection { 0 }
  func cleanUpConnection(_ connection: FlutterBinaryMessengerConnection) {}
}

#Preview {
  let vm = NavigationSplitViewModel(binaryMessenger: PreviewBinaryMessenger())
  NavigationStack {
    SidebarView().environmentObject(vm)
  }
}
