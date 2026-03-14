//
//  TagsPickerView.swift
//  Runner
//
//  Created by Martin Chaine on 13/03/2026.
//

import SwiftUI

struct TagsPickerView: View {
  let initialSelection: [String]
  let title: String
  let fetchTags: () async throws -> [String]
  let onConfirm: ([String]) -> Void

  @Environment(\.dismiss) private var dismiss
  @State private var allTags: [String] = []
  @State private var selected: Set<String>
  @State private var searchText = ""
  @State private var isLoading = true
  @State private var loadError = false
  @State private var showingAddAlert = false
  @State private var newTagText = ""

  init(
    initialSelection: [String],
    title: String,
    fetchTags: @escaping () async throws -> [String],
    onConfirm: @escaping ([String]) -> Void
  ) {
    self.initialSelection = initialSelection
    self.title = title
    self.fetchTags = fetchTags
    self.onConfirm = onConfirm
    _selected = State(initialValue: Set(initialSelection))
  }

  var filteredTags: [String] {
    searchText.isEmpty
      ? allTags
      : allTags.filter {
        $0.localizedCaseInsensitiveContains(searchText)
      }
  }

  var body: some View {
    NavigationStack {
      List(filteredTags, id: \.self) { tag in
        Button {
          if selected.contains(tag) {
            selected.remove(tag)
          } else {
            selected.insert(tag)
          }
        } label: {
          HStack {
            Text(tag).foregroundStyle(.foreground)
            Spacer()
            if selected.contains(tag) { Image(systemName: "checkmark") }
          }
        }
      }
      .searchable(text: $searchText)
      .overlay {
        if isLoading {
          ProgressView()
        } else if loadError {
          VStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle")
            Text("Failed to load tags")
          }.foregroundStyle(.secondary)
        }
      }
      .navigationTitle(title)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button {
            dismiss()
          } label: {
            Image(systemName: "xmark")
          }
        }
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            showingAddAlert = true
          } label: {
            Image(systemName: "plus")
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button {
            onConfirm(Array(selected))
            dismiss()
          } label: {
            Image(systemName: "checkmark")
          }
        }
      }
      .alert("New tag", isPresented: $showingAddAlert) {
        TextField("Tag name", text: $newTagText)
        Button("Add") {
          let tag = newTagText.trimmingCharacters(in: .whitespaces)
          guard !tag.isEmpty else { return }
          allTags.append(tag)
          selected.insert(tag)
          newTagText = ""
        }
        Button("Cancel", role: .cancel) { newTagText = "" }
      }
      .task {
        do {
          allTags = try await fetchTags()
        } catch {
          loadError = true
        }
        isLoading = false
      }
    }
  }
}

#Preview {
  TagsPickerView(
    initialSelection: ["swift", "ios"],
    title: "Select tags",
    fetchTags: { ["android", "flutter", "ios", "swift"] },
    onConfirm: { _ in },
  )
}
