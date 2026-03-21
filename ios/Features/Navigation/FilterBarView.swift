import SwiftUI

struct FilterBarView: View {
  @EnvironmentObject var viewModel: NavigationSplitViewModel
  @State private var showTagsPicker = false
  @State private var showDomainsPicker = false
  @State private var availableTags: [String] = []
  @State private var availableDomains: [String] = []

  private var stateFilterIndex: Int { Int(viewModel.filterState.stateFilter) }
  private var isStarred: Bool { viewModel.filterState.onlyStarred }
  private var activeTags: [String] { viewModel.filterState.tags }
  private var activeDomains: [String] { viewModel.filterState.domains }

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 8) {
        FilterChip(
          label: String(localized: "filters_articleStateAll"),
          isActive: stateFilterIndex == 0
        ) { viewModel.setStateFilter(0) }
        FilterChip(
          label: String(localized: "filters_articleStateUnread"),
          isActive: stateFilterIndex == 1
        ) { viewModel.setStateFilter(1) }
        FilterChip(
          label: String(localized: "filters_articleStateArchived"),
          isActive: stateFilterIndex == 2
        ) { viewModel.setStateFilter(2) }
        FilterChip(
          label: String(localized: "filters_articleFavoriteStarred"),
          systemImage: "star.fill",
          isActive: isStarred
        ) { viewModel.setOnlyStarred(!isStarred) }
        FilterChip(
          label: activeTags.isEmpty
            ? String(localized: "filters_articleTags")
            : String.localizedStringWithFormat(
              NSLocalizedString("filters_articleTagsCount", comment: ""),
              Int64(activeTags.count)
            ),
          isActive: !activeTags.isEmpty
        ) {
          Task {
            if availableTags.isEmpty {
              availableTags = (try? await loadTags()) ?? []
            }
            showTagsPicker = true
          }
        }
        .sheet(isPresented: $showTagsPicker) {
          MultiSelectPickerView(
            title: String(localized: "filters_articleTags"),
            items: availableTags,
            selection: activeTags
          ) { selected in viewModel.setTags(selected) }
        }
        FilterChip(
          label: activeDomains.isEmpty
            ? String(localized: "filters_articleDomains")
            : String.localizedStringWithFormat(
              NSLocalizedString("filters_articleDomainsCount", comment: ""),
              Int64(activeDomains.count)
            ),
          isActive: !activeDomains.isEmpty
        ) {
          Task {
            if availableDomains.isEmpty {
              availableDomains = (try? await loadDomains()) ?? []
            }
            showDomainsPicker = true
          }
        }
        .sheet(isPresented: $showDomainsPicker) {
          MultiSelectPickerView(
            title: String(localized: "filters_articleDomains"),
            items: availableDomains,
            selection: activeDomains
          ) { selected in viewModel.setDomains(selected) }
        }
      }
      .padding(.horizontal)
      .padding(.vertical, 6)
    }
  }

  private func loadTags() async throws -> [String] {
    try await withCheckedThrowingContinuation { continuation in
      viewModel.flutterApi.getAvailableTags { result in
        continuation.resume(with: result)
      }
    }
  }

  private func loadDomains() async throws -> [String] {
    try await withCheckedThrowingContinuation { continuation in
      viewModel.flutterApi.getAvailableDomains { result in
        continuation.resume(with: result)
      }
    }
  }
}

private struct FilterChip: View {
  let label: String
  var systemImage: String? = nil
  let isActive: Bool
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      HStack(spacing: 4) {
        if let systemImage { Image(systemName: systemImage) }
        Text(label)
      }
      .font(.subheadline)
      .padding(.horizontal, 12)
      .padding(.vertical, 6)
      .background(isActive ? Color.accentColor : Color(.systemGray6))
      .foregroundStyle(isActive ? .white : .primary)
      .clipShape(Capsule())
    }
    .buttonStyle(.plain)
  }
}

private struct MultiSelectPickerView: View {
  let title: String
  let items: [String]
  let onConfirm: ([String]) -> Void

  @State private var selected: Set<String>
  @Environment(\.dismiss) private var dismiss

  init(
    title: String,
    items: [String],
    selection: [String],
    onConfirm: @escaping ([String]) -> Void
  ) {
    self.title = title
    self.items = items
    self.onConfirm = onConfirm
    self._selected = State(initialValue: Set(selection))
  }

  var body: some View {
    NavigationStack {
      List(items, id: \.self) { item in
        Button {
          if selected.contains(item) {
            selected.remove(item)
          } else {
            selected.insert(item)
          }
        } label: {
          HStack {
            Text(item)
            Spacer()
            if selected.contains(item) {
              Image(systemName: "checkmark")
                .foregroundStyle(.tint)
            }
          }
        }
        .foregroundStyle(.primary)
      }
      .navigationTitle(title)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            onConfirm(Array(selected))
            dismiss()
          }
        }
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") { dismiss() }
        }
      }
    }
  }
}
