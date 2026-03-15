//
//  ArticleSheetView.swift
//  Runner
//
//  Created by Martin Chaine on 12/03/2026.
//

import Flutter
import SwiftUI

struct ArticleSheetView<ViewModel: ArticleSheetViewModelProtocol>: View {
  @ObservedObject var viewModel: ViewModel
  @Environment(\.dismiss) private var dismiss
  @State private var showingTagsPicker = false

  var body: some View {
    NavigationStack {
      Group {
        if let data = viewModel.data {
          List {
            Section {
              LabeledContent(String(localized: "articlefields_title")) {
                Text(data.title).textSelection(.enabled)
              }
              LabeledContent(String(localized: "articlefields_website")) {
                Text(data.domain ?? "").textSelection(.enabled)
              }
              LabeledContent(String(localized: "articlefields_readingTime")) {
                Text(String(format: String(localized: "article_readingTime"), data.readingTime))
                  .textSelection(.enabled)
              }
            }

            Section(String(localized: "articlefields_tags")) {
              let tags = data.tags
              ForEach(tags, id: \.self) { tag in
                Text(tag)
                  .swipeActions {
                    Button(role: .destructive) {
                      viewModel.setTags(tags.filter { $0 != tag })
                    } label: {
                      Image(systemName: "trash")
                    }
                  }
              }
              Button(String(localized: "article_addTags")) { showingTagsPicker = true }
            }

            Section {
              Button {
                viewModel.refetchContent()
              } label: {
                HStack {
                  Text(String(localized: "article_refetchContent"))
                  if viewModel.isRefetching {
                    Spacer()
                    ProgressView()
                  }
                }
              }
              .disabled(viewModel.isRefetching)
              if let url = URL(string: data.link) {
                ShareLink(item: url, subject: Text(data.title)) {
                  Text(String(localized: "g_share"))
                }
              }
              Button(String(localized: "article_openInBrowser")) { viewModel.openInBrowser() }
            }
          }
        } else {
          ProgressView()
        }
      }
      .sheet(isPresented: $showingTagsPicker) {
        TagsPickerView(
          initialSelection: viewModel.data?.tags ?? [],
          title: String(localized: "articlefields_tags"),
          fetchTags: { try await viewModel.getAllTags() },
          onConfirm: { viewModel.setTags($0) }
        )
      }
      .navigationTitle(String(localized: "g_article"))
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button {
            viewModel.notifyClose()
            dismiss()
          } label: {
            Image(systemName: "xmark")
          }
        }
      }
    }
  }
}

private class PreviewViewModel: ObservableObject, ArticleSheetViewModelProtocol {
  var data: ArticleSheetData? = ArticleSheetData(
    title:
      "A very long article title that definitely spans more than one line on a mobile screen",
    link: "https://example.com",
    domain: "example.com",
    readingTime: 5,
    tags: ["swift", "ios"]
  )

  func notifyClose() {}
  func getAllTags() async throws -> [String] {
    ["android", "flutter", "ios", "swift"]
  }

  var isRefetching: Bool = false
  func refetchContent() {}
  func setTags(_: [String]) {}
  func openInBrowser() {}
}

#Preview {
  ArticleSheetView(viewModel: PreviewViewModel())
}
