//
//  ArticleSheetViewModel.swift
//  Runner
//
//  Created by Martin Chaine on 11/03/2026.
//

import Flutter
import SafariServices
import SwiftUI

protocol ArticleSheetViewModelProtocol: ObservableObject {
  var data: ArticleSheetData? { get }
  var isRefetching: Bool { get }
  func notifyClose()
  func getAllTags() async throws -> [String]
  func refetchContent()
  func setTags(_ tags: [String])
  func openInBrowser()
}

class ArticleSheetViewModel: NSObject, ArticleSheetApi,
  ArticleSheetViewModelProtocol,
  UIAdaptivePresentationControllerDelegate
{
  private let flutterApi: ArticleSheetFlutterApi
  private weak var presenter: UIViewController?
  @Published var data: ArticleSheetData?
  @Published var isRefetching: Bool = false

  init(binaryMessenger: FlutterBinaryMessenger, presenter: UIViewController) {
    flutterApi = ArticleSheetFlutterApi(binaryMessenger: binaryMessenger)
    self.presenter = presenter
    super.init()
    ArticleSheetApiSetup.setUp(binaryMessenger: binaryMessenger, api: self)
  }

  func update(data: ArticleSheetData) throws {
    self.data = data
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

  func close() throws {
    presenter?.presentedViewController?.dismiss(animated: true)
  }

  func getAllTags() async throws -> [String] {
    try await withCheckedThrowingContinuation { continuation in
      flutterApi.getAllTags { result in
        continuation.resume(with: result)
      }
    }
  }

  func setTags(_ tags: [String]) {
    flutterApi.setTags(tags: tags) { _ in }
  }

  func refetchContent() {
    isRefetching = true
    flutterApi.refetchContent { [weak self] _ in
      DispatchQueue.main.async { self?.isRefetching = false }
    }
  }

  func openInBrowser() {
    guard let urlString = data?.link, let url = URL(string: urlString) else {
      return
    }
    let safari = SFSafariViewController(url: url)
    let topPresenter = presenter?.presentedViewController ?? presenter
    topPresenter?.present(safari, animated: true)
  }

  func notifyClose() {
    flutterApi.onClose { _ in }
  }

  func presentationControllerDidDismiss(
    _: UIPresentationController
  ) {
    notifyClose()
  }
}
