import SwiftUI

struct ArticleDetailView: View {
  @EnvironmentObject var viewModel: NavigationSplitViewModel
  @Environment(\.openURL) private var openURL
  @State private var showDeleteAlert = false
  @State private var showReadingSettings = false

  var body: some View {
    if let content = viewModel.articleContent, let html = content.html {
      ArticleWebView(
        html: html,
        title: viewModel.articleData?.title,
        readingProgress: content.readingProgress,
        readingSettings: viewModel.readingSettings,
        onProgressChange: { progress in
          viewModel.onReadingProgressChanged(articleId: content.id, progress: progress)
        }
      )
      .navigationBarTitleDisplayMode(.inline)
      .ignoresSafeArea(edges: .bottom)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          let isArchived = viewModel.articleData?.isArchived ?? false
          Button {
            viewModel.setArticleArchived(content.id, archived: !isArchived)
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
            viewModel.setArticleStarred(content.id, starred: !isStarred)
          } label: {
            Label(
              isStarred
                ? String(localized: "article_unstar")
                : String(localized: "article_star"),
              systemImage: isStarred ? "star.fill" : "star"
            )
          }
          Button {
            viewModel.openArticleSheet(id: content.id)
          } label: {
            Label(
              String(localized: "article_details"),
              systemImage: "info.circle"
            )
          }

          Menu {
            Button {
              showReadingSettings = true
            } label: {
              Label(
                String(localized: "article_readingSettings"),
                systemImage: "textformat.size"
              )
            }

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
      .sheet(isPresented: $showReadingSettings) {
        ReadingSettingsView().environmentObject(viewModel)
      }
      .alert(String(localized: "article_delete"), isPresented: $showDeleteAlert) {
        Button(String(localized: "g_delete"), role: .destructive) {
          viewModel.deleteArticle(id: content.id)
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
