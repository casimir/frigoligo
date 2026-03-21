import SwiftUI

struct ArticleDetailView: View {
  @EnvironmentObject var viewModel: NavigationSplitViewModel
  @Environment(\.openURL) private var openURL
  @State private var showDeleteAlert = false

  var body: some View {
    if let content = viewModel.articleContent, let html = content.html {
      ArticleWebView(
        html: html,
        readingProgress: content.readingProgress,
        onProgressChange: { progress in
          viewModel.flutterApi.onReadingProgressChanged(
            articleId: Int64(content.id),
            progress: progress
          ) { _ in }
        }
      )
      .ignoresSafeArea(edges: .bottom)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          let isArchived = viewModel.articleData?.isArchived ?? false
          Button {
            viewModel.flutterApi.setArticleArchived(
              id: content.id,
              archived: !isArchived
            ) { _ in }
          } label: {
            Label(
              isArchived
                ? String(localized: "article_unarchive")
                : String(localized: "article_archive"),
              systemImage: isArchived ? "tray.and.arrow.up" : "archivebox"
            )
          }

          let isStarred = viewModel.articleData?.isStarred ?? false
          Button {
            viewModel.flutterApi.setArticleStarred(
              id: content.id,
              starred: !isStarred
            ) { _ in }
          } label: {
            Label(
              isStarred
                ? String(localized: "article_unstar")
                : String(localized: "article_star"),
              systemImage: isStarred ? "star.fill" : "star"
            )
          }
          Button {
            viewModel.flutterApi.openArticleSheet(id: Int64(content.id)) { _ in
            }
          } label: {
            Label(
              String(localized: "article_details"),
              systemImage: "info.circle"
            )
          }

          Menu {
            if let urlString = viewModel.articleData?.url,
              let url = URL(string: urlString)
            {
              if let title = viewModel.articleData?.title {
                ShareLink(item: url, subject: Text(title)) {
                  Label(
                    String(localized: "article_share"),
                    systemImage: "square.and.arrow.up"
                  )
                }
              }
              Button {
                openURL(url)
              } label: {
                Label(
                  String(localized: "article_openInBrowser"),
                  systemImage: "safari"
                )
              }
            }

            Button(role: .destructive) {
              showDeleteAlert = true
            } label: {
              Label(String(localized: "article_delete"), systemImage: "trash")
            }
          } label: {
            Label("More", systemImage: "ellipsis.circle")
          }
        }
      }
      .alert(String(localized: "article_delete"), isPresented: $showDeleteAlert) {
        Button(String(localized: "g_delete"), role: .destructive) {
          viewModel.flutterApi.deleteArticle(id: Int64(content.id)) { _ in }
        }
        if #available(iOS 26, *) {
          Button(role: .cancel) {}
        } else {
          Button("Cancel", role: .cancel) {}
        }
      }
    } else {
      ProgressView()
    }
  }
}
