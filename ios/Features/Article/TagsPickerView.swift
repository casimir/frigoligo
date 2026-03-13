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
  let fetchTags: () async -> [String]
  let onConfirm: ([String]) -> Void

  @Environment(\.dismiss) private var dismiss
  @State private var allTags: [String] = []
  @State private var selected: Set<String>
  @State private var searchText = ""
  @State private var isLoading = true
  @State private var showingAddAlert = false
  @State private var newTagText = ""

  init(
    initialSelection: [String],
    title: String,
    fetchTags: @escaping () async -> [String],
    onConfirm: @escaping ([String]) -> Void
  ) {
    self.initialSelection = initialSelection
    self.title = title
    self.fetchTags = fetchTags
    self.onConfirm = onConfirm
    _selected = State(initialValue: Set(initialSelection))
  }

  var filteredTags: [String] {
    searchText.isEmpty ? allTags : allTags.filter {
      $0.localizedCaseInsensitiveContains(searchText)
    }
  }

  var body: some View {
    NavigationStack {
      List(filteredTags, id: \.self) { tag in
        Button {
          if selected.contains(tag) { selected.remove(tag) }
          else { selected.insert(tag) }
        } label: {
          HStack {
            Text(tag).foregroundStyle(.primary)
            Spacer()
            if selected.contains(tag) { Image(systemName: "checkmark") }
          }
        }
      }
      .searchable(text: $searchText)
      .overlay { if isLoading { ProgressView() } }
      .navigationTitle(title)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button("Cancel") { dismiss() }
        }
        ToolbarItem(placement: .topBarTrailing) {
          Button { showingAddAlert = true } label: {
            Image(systemName: "plus")
          }
        }
        ToolbarItem(placement: .bottomBar) {
          Button("Done") { onConfirm(Array(selected)); dismiss() }
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
        allTags = await fetchTags()
        isLoading = false
      }
    }
  }
}
