import Flutter

class NavigationSplitViewModel: NSObject, ObservableObject, NavigationSplitApi,
  UIAdaptivePresentationControllerDelegate
{
  @Published var articleIds: [Int64] = []
  @Published var syncState: NavigationSyncState = NavigationSyncState(
    isWorking: false, progressValue: nil, pendingCount: 0)
  @Published var filterState: NavigationFilterState = NavigationFilterState(
    text: "", textMode: .all, stateFilter: .unread, onlyStarred: false,
    tags: [], domains: [])
  @Published var selectedArticleId: Int64? = nil {
    didSet {
      articleContent = nil
      articleData = nil
      if let id = selectedArticleId {
        flutterApi.onArticleSelected(id: id) { _ in }
      }
    }
  }
  @Published var articleContent: ArticleContent? = nil
  @Published var articleData: ArticleRowData? = nil
  @Published var readingSettings: ArticleReadingSettings = ArticleReadingSettings(
    fontSize: 16, fontFamily: "Lato", justifyText: false)
  @Published var showSaveLinkSheet = false

  private let flutterApi: NavigationSplitFlutterApi
  weak var engine: FlutterEngine?
  weak var presenter: UIViewController?

  init(binaryMessenger: FlutterBinaryMessenger) {
    self.flutterApi = NavigationSplitFlutterApi(binaryMessenger: binaryMessenger)
    super.init()
    NavigationSplitApiSetup.setUp(binaryMessenger: binaryMessenger, api: self)
  }

  // MARK: - NavigationSplitApi

  func updateArticleIds(ids: [Int64]) throws {
    articleIds = ids
    if let selected = selectedArticleId, !ids.contains(selected) {
      selectedArticleId = nil
    }
  }

  func updateSyncState(state: NavigationSyncState) throws {
    syncState = state
  }

  func updateFilterState(state: NavigationFilterState) throws {
    if filterState != state { filterState = state }
  }

  func updateArticleContent(content: ArticleContent) throws {
    articleContent = content
  }

  func updateArticleData(data: ArticleRowData) throws {
    articleData = data
  }

  func updateReadingSettings(settings: ArticleReadingSettings) throws {
    if readingSettings != settings { readingSettings = settings }
  }

  // MARK: - Filter actions

  func setSearchText(_ text: String) {
    flutterApi.setSearchText(text: text) { _ in }
  }

  func setTextMode(_ mode: NavigationSearchTextMode) {
    flutterApi.setTextMode(mode: mode) { _ in }
  }

  func setStateFilter(_ state: NavigationStateFilter) {
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

  func fetchAvailableTags() async -> [String] {
    await withCheckedContinuation { continuation in
      flutterApi.getAvailableTags { result in
        continuation.resume(returning: (try? result.get()) ?? [])
      }
    }
  }

  func fetchAvailableDomains() async -> [String] {
    await withCheckedContinuation { continuation in
      flutterApi.getAvailableDomains { result in
        continuation.resume(returning: (try? result.get()) ?? [])
      }
    }
  }

  // MARK: - Sync actions

  func refresh() async {
    await withCheckedContinuation { continuation in
      flutterApi.refresh { _ in continuation.resume() }
    }
  }

  func setArticleArchived(_ id: Int64, archived: Bool) {
    flutterApi.setArticleArchived(id: id, archived: archived) { _ in }
  }

  func setArticleStarred(_ id: Int64, starred: Bool) {
    flutterApi.setArticleStarred(id: id, starred: starred) { _ in }
  }

  // MARK: - Article actions

  func getArticleRowData(id: Int64) async -> ArticleRowData? {
    await withCheckedContinuation { continuation in
      flutterApi.getArticleRowData(id: id) { result in
        continuation.resume(returning: try? result.get())
      }
    }
  }

  func openArticleSheet(id: Int64) {
    flutterApi.openArticleSheet(id: id) { _ in }
  }

  func deleteArticle(id: Int64) {
    flutterApi.deleteArticle(id: id) { _ in }
  }

  func onReadingProgressChanged(articleId: Int64, progress: Double) {
    flutterApi.onReadingProgressChanged(articleId: articleId, progress: progress) { _ in }
  }

  func setReadingSettings(_ settings: ArticleReadingSettings) {
    flutterApi.setReadingSettings(settings: settings) { _ in }
  }

  // MARK: - Secondary screens

  func openSettings() {
    flutterApi.openSettings { [weak self] _ in self?.presentSecondary() }
  }

  func openSaveLink() {
    showSaveLinkSheet = true
  }

  func saveLink(url: String) async throws {
    try await withCheckedThrowingContinuation { continuation in
      flutterApi.saveLink(url: url) { result in
        switch result {
        case .success: continuation.resume()
        case .failure(let error): continuation.resume(throwing: error)
        }
      }
    }
  }

  private func presentSecondary() {
    guard let engine, let presenter, presenter.presentedViewController == nil else { return }
    let flutterVC = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    flutterVC.modalPresentationStyle = .pageSheet
    if let sheet = flutterVC.sheetPresentationController {
      sheet.detents = [.large()]
      sheet.prefersGrabberVisible = true
      sheet.prefersScrollingExpandsWhenScrolledToEdge = false
    }
    flutterVC.presentationController?.delegate = self
    presenter.present(flutterVC, animated: true)
  }

  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    flutterApi.secondaryScreenDidClose { _ in }
  }
}
