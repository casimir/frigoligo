import Flutter

class NavigationSplitViewModel: NSObject, ObservableObject, NavigationSplitApi {
  @Published var articleIds: [Int] = []
  @Published var syncState: NavigationSyncState = NavigationSyncState(
    isWorking: false, progressValue: nil, pendingCount: 0)
  @Published var filterState: NavigationFilterState = NavigationFilterState(
    text: "", textMode: 0, stateFilter: 0, onlyStarred: false, tags: [], domains: [])
  @Published var selectedArticleId: Int? = nil {
    didSet {
      articleContent = nil
      articleData = nil
      if let id = selectedArticleId {
        flutterApi.onArticleSelected(id: Int64(id)) { _ in }
      }
    }
  }
  @Published var articleContent: ArticleContent? = nil
  @Published var articleData: ArticleRowData? = nil
  @Published var readingSettings: ArticleReadingSettings = ArticleReadingSettings(
    fontSize: 16, fontFamily: "Lato", justifyText: false)

  let flutterApi: NavigationSplitFlutterApi

  init(binaryMessenger: FlutterBinaryMessenger) {
    self.flutterApi = NavigationSplitFlutterApi(binaryMessenger: binaryMessenger)
    super.init()
    NavigationSplitApiSetup.setUp(binaryMessenger: binaryMessenger, api: self)
  }

  // MARK: - NavigationSplitApi

  func updateArticleIds(ids: [Int64]) throws {
    let converted = ids.map { Int($0) }
    DispatchQueue.main.async {
      self.articleIds = converted
      if let selected = self.selectedArticleId, !converted.contains(selected) {
        self.selectedArticleId = nil
      }
    }
  }

  func updateSyncState(state: NavigationSyncState) throws {
    DispatchQueue.main.async { self.syncState = state }
  }

  func updateFilterState(state: NavigationFilterState) throws {
    DispatchQueue.main.async { self.filterState = state }
  }

  func updateArticleContent(content: ArticleContent) throws {
    DispatchQueue.main.async { self.articleContent = content }
  }

  func updateArticleData(data: ArticleRowData) throws {
    DispatchQueue.main.async { self.articleData = data }
  }

  func updateReadingSettings(settings: ArticleReadingSettings) throws {
    DispatchQueue.main.async {
      if self.readingSettings != settings { self.readingSettings = settings }
    }
  }

  // MARK: - Filter actions

  func setSearchText(_ text: String) {
    flutterApi.setSearchText(text: text) { _ in }
  }

  func setTextMode(_ mode: Int64) {
    flutterApi.setTextMode(mode: mode) { _ in }
  }

  func setStateFilter(_ state: Int64) {
    flutterApi.setStateFilter(state: state) { _ in }
  }

  func setOnlyStarred(_ value: Bool) {
    flutterApi.setOnlyStarred(onlyStarred: value) { _ in }
  }

  func setTags(_ tags: [String]) {
    flutterApi.setTags(tags: tags) { _ in }
  }

  func setDomains(_ domains: [String]) {
    flutterApi.setDomains(domains: domains) { _ in }
  }

  func filterByTag(_ tag: String) {
    flutterApi.filterByTag(tag: tag) { _ in }
  }

  // MARK: - Sync actions

  func refresh() async {
    await withCheckedContinuation { continuation in
      flutterApi.refresh { _ in continuation.resume() }
    }
  }

  func setArticleArchived(_ id: Int, archived: Bool) {
    flutterApi.setArticleArchived(id: Int64(id), archived: archived) { _ in }
  }

  func setArticleStarred(_ id: Int, starred: Bool) {
    flutterApi.setArticleStarred(id: Int64(id), starred: starred) { _ in }
  }

  // MARK: - Presentation (Phase 2)

  func openSettings() {
    // TODO: needs a Pigeon call to trigger Flutter navigation to the settings route
  }

  func openSaveLink() {
    // TODO: needs a Pigeon call to trigger Flutter navigation to the save-link route
  }
}
