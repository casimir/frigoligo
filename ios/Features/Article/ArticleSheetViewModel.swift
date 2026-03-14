//
//  ArticleSheetViewModel.swift
//  Runner
//
//  Created by Martin Chaine on 11/03/2026.
//
import Flutter
import SwiftUI

protocol ArticleSheetViewModelProtocol: ObservableObject {
  var data: ArticleSheetData? { get }
  func notifyClose()
  func getAllTags() async throws -> [String]
  func refetchContent()
  func setTags(_ tags: [String])
  func shareArticle()
  func openInBrowser()
}

class ArticleSheetViewModel: NSObject, ArticleSheetApi,
  ArticleSheetViewModelProtocol,
  UIAdaptivePresentationControllerDelegate
{
  private let flutterApi: ArticleSheetFlutterApi
  private weak var presenter: UIViewController?
  @Published var data: ArticleSheetData?

  init(binaryMessenger: FlutterBinaryMessenger, presenter: UIViewController) {
    flutterApi = ArticleSheetFlutterApi(binaryMessenger: binaryMessenger)
    self.presenter = presenter
    super.init()
    ArticleSheetApiSetup.setUp(binaryMessenger: binaryMessenger, api: self)
  }

  func open() throws {
    guard presenter?.presentedViewController == nil else { return }

    let hosting = UIHostingController(
      rootView: ArticleSheetView(viewModel: self)
    )
    hosting.modalPresentationStyle = .pageSheet
    hosting.presentationController?.delegate = self
    presenter?.present(hosting, animated: true)
  }

  func presentationControllerDidDismiss(
    _: UIPresentationController
  ) {
    notifyClose()
  }

  func update(data: ArticleSheetData) throws {
    self.data = data
  }

  func close() throws {
    presenter?.presentedViewController?.dismiss(animated: true)
  }

  func notifyClose() {
    flutterApi.onClose { _ in }
  }

  func getAllTags() async throws -> [String] {
    try await withCheckedThrowingContinuation { continuation in
      flutterApi.getAllTags { result in
        continuation.resume(with: result)
      }
    }
  }

  func refetchContent() {
    flutterApi.refetchContent { _ in }
  }

  func setTags(_ tags: [String]) {
    flutterApi.setTags(tags: tags) { _ in }
  }

  func shareArticle() {
    guard let urlString = data?.link, let url = URL(string: urlString),
      let presenter
    else { return }
    var items: [Any] = [url]
    if let title = data?.title { items.insert(title, at: 0) }
    let activity = UIActivityViewController(
      activityItems: items,
      applicationActivities: nil
    )
    let topPresenter = presenter.presentedViewController ?? presenter
    topPresenter.present(activity, animated: true)
  }

  func openInBrowser() {
    guard let urlString = data?.link, let url = URL(string: urlString) else {
      return
    }
    UIApplication.shared.open(url)
  }
}
