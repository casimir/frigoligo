import SwiftUI

struct ArticleDetailPlaceholder: View {
  var body: some View {
    VStack(spacing: 12) {
      Image(systemName: "doc.text")
        .font(.system(size: 48))
        .foregroundStyle(.secondary)
      Text("Select an article")
        .font(.title3)
        .foregroundStyle(.secondary)
    }
  }
}
