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
      List {
        if let data = viewModel.data {
          let labels = data.labels
          Section {
            LabeledContent(labels.title) { Text(data.title ?? "").textSelection(.enabled) }
            LabeledContent(labels.website) { Text(data.domain ?? "").textSelection(.enabled) }
            LabeledContent(labels.readingTime) {
              Text(data.readingTime ?? "").textSelection(.enabled)
            }
          }

          Section(labels.tags) {
            let tags = data.tags ?? []
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
            Button(labels.addTags) { showingTagsPicker = true }
          }

          Section {
            Button(labels.refetchContent) { viewModel.refetchContent() }
            Button(labels.share) { viewModel.shareArticle() }
            Button(labels.openInBrowser) { viewModel.openInBrowser() }
          }
        }
      }
      .sheet(isPresented: $showingTagsPicker) {
        TagsPickerView(
          initialSelection: viewModel.data?.tags ?? [],
          title: viewModel.data?.labels.tags ?? "",
          fetchTags: { await viewModel.getAllTags() },
          onConfirm: { viewModel.setTags($0) }
        )
      }
      .navigationTitle(viewModel.data?.labels.sheetTitle ?? "")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button(action: { viewModel.close(); dismiss() }) {
            Image(systemName: "xmark")
          }
        }
      }
    }
  }
}

private class PreviewViewModel: ObservableObject, ArticleSheetViewModelProtocol
{
  var data: ArticleSheetData? = ArticleSheetData(
    title:
      "A very long article title that definitely spans more than one line on a mobile screen",
    link: "https://example.com",
    domain: "example.com",
    readingTime: "5 mins",
    tags: ["swift", "ios"],
    labels: ArticleSheetLabels(
      addTags: "Add tags",
      openInBrowser: "Open in browser",
      readingTime: "Reading time",
      refetchContent: "Re-fetch content",
      share: "Share",
      sheetTitle: "Article",
      tags: "Tags",
      title: "Title",
      website: "Website"
    )
  )

  func close() {}
  func getAllTags() async -> [String] { [] }
  func refetchContent() {}
  func setTags(_ tags: [String]) {}
  func shareArticle() {}
  func openInBrowser() {}
}

#Preview {
  ArticleSheetView(viewModel: PreviewViewModel())
}
