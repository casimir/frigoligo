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
  func close()
  func getAllTags() async -> [String]
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
    self.flutterApi = ArticleSheetFlutterApi(binaryMessenger: binaryMessenger)
    self.presenter = presenter
    super.init()
    ArticleSheetApiSetup.setUp(binaryMessenger: binaryMessenger, api: self)
  }

  func open() throws {
    let hosting = UIHostingController(
      rootView: ArticleSheetView(viewModel: self)
    )
    hosting.modalPresentationStyle = .pageSheet
    hosting.presentationController?.delegate = self
    presenter?.present(hosting, animated: true)
  }

  func presentationControllerDidDismiss(
    _ presentationController: UIPresentationController
  ) {
    flutterApi.close { _ in }
  }

  func update(data: ArticleSheetData) throws {
    self.data = data
  }

  func close() {
    flutterApi.close { _ in }
  }

  func getAllTags() async -> [String] {
    await withCheckedContinuation { continuation in
      flutterApi.getAllTags { result in
        continuation.resume(returning: (try? result.get()) ?? [])
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
          let presenter else { return }
    var items: [Any] = [url]
    if let title = data?.title { items.insert(title, at: 0) }
    let activity = UIActivityViewController(activityItems: items, applicationActivities: nil)
    let topPresenter = presenter.presentedViewController ?? presenter
    topPresenter.present(activity, animated: true)
  }

  func openInBrowser() {
    guard let urlString = data?.link, let url = URL(string: urlString) else { return }
    UIApplication.shared.open(url)
  }
}
