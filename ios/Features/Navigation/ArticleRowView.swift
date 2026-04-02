import SwiftUI

struct ArticleRowView: View {
  @EnvironmentObject var viewModel: NavigationSplitViewModel
  let id: Int64

  @State private var data: ArticleRowData?

  var body: some View {
    if let data {
      HStack(alignment: .top, spacing: 12) {
        VStack(alignment: .leading, spacing: 4) {
          HStack(spacing: 4) {
            if let domain = data.domainName, !domain.isEmpty {
              Text(domain)
                .font(.caption)
                .foregroundStyle(.secondary)
              Text("·")
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            Text("\(data.readingTime) min")
              .font(.caption)
              .foregroundStyle(.secondary)
            if data.isStarred {
              Image(systemName: "star.fill")
                .font(.caption)
                .foregroundStyle(.yellow)
            }
            if data.isArchived {
              Image(systemName: "archivebox.fill")
                .font(.caption)
                .foregroundStyle(.secondary)
            }
          }
          Text(data.title)
            .font(.headline)
            .lineLimit(3)
          if !data.tags.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 6) {
                ForEach(data.tags, id: \.self) { tag in
                  Button(tag) {
                    viewModel.filterByTag(tag)
                  }
                  .font(.caption2)
                  .padding(.horizontal, 8)
                  .padding(.vertical, 3)
                  .background(.tint.opacity(0.12))
                  .foregroundStyle(.tint)
                  .clipShape(Capsule())
                }
              }
            }
          }
        }
        Spacer(minLength: 0)
        if let url = data.previewPictureUrl.flatMap(URL.init) {
          AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
              image
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            default:
              Color.clear.frame(width: 80, height: 80)
            }
          }
        }
      }
      .contentShape(Rectangle())
      .swipeActions(edge: .leading) {
        Button {
          viewModel.setArticleArchived(id, archived: !data.isArchived)
        } label: {
          Label(
            data.isArchived ? "Unarchive" : "Archive",
            systemImage: data.isArchived ? "tray.and.arrow.up" : "archivebox"
          )
        }
        .tint(data.isArchived ? .orange : .green)
      }
      .swipeActions(edge: .trailing) {
        Button {
          viewModel.setArticleStarred(id, starred: !data.isStarred)
        } label: {
          Label(
            data.isStarred ? "Unstar" : "Star",
            systemImage: data.isStarred ? "star.slash" : "star"
          )
        }
        .tint(.yellow)
      }
    } else {
      ProgressView()
        .frame(maxWidth: .infinity, minHeight: 60)
        .task {
          data = await viewModel.getArticleRowData(id: id)
        }
    }
  }
}
