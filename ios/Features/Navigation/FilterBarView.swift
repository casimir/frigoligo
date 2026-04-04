import SwiftUI

struct FilterBarView: View {
  @EnvironmentObject var viewModel: NavigationSplitViewModel
  @State private var showTagsPicker = false
  @State private var showDomainsPicker = false
  @State private var availableTags: [String] = []
  @State private var availableDomains: [String] = []

  private var isStarred: Bool { viewModel.filterState.onlyStarred }
  private var activeTags: [String] { viewModel.filterState.tags }
  private var activeDomains: [String] { viewModel.filterState.domains }

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 8) {
        Menu {
          Button {
            viewModel.setStateFilter(.all)
          } label: {
            Label(String(localized: "filters_articleStateAll"), systemImage: "tray.2")
          }
          Button {
            viewModel.setStateFilter(.unread)
          } label: {
            Label(String(localized: "filters_articleStateUnread"), systemImage: "book")
          }
          Button {
            viewModel.setStateFilter(.archived)
          } label: {
            Label(String(localized: "filters_articleStateArchived"), systemImage: "archivebox")
          }
        } label: {
          FilterChipLabel(
            label: labelForStateFilter(viewModel.filterState.stateFilter),
            showsChevron: true,
            isActive: viewModel.filterState.stateFilter != .all
          )
        }
        FilterChip(
          label: String(localized: "filters_articleFavoriteStarred"),
          isActive: isStarred
        ) { viewModel.setOnlyStarred(!isStarred) }
        FilterChip(
          label: activeTags.isEmpty
            ? String(localized: "filters_articleTags")
            : String.localizedStringWithFormat(
              NSLocalizedString("filters_articleTagsCount", comment: ""),
              Int64(activeTags.count)
            ),
          showsChevron: true,
          isActive: !activeTags.isEmpty
        ) { showTagsPicker = true }
        .sheet(isPresented: $showTagsPicker) {
          MultiSelectPickerView(
            title: String(localized: "filters_articleTags"),
            items: availableTags,
            selection: activeTags
          ) { selected in viewModel.setTags(selected) }
        }
        .task(id: showTagsPicker) {
          if showTagsPicker { availableTags = await viewModel.fetchAvailableTags() }
        }
        FilterChip(
          label: activeDomains.isEmpty
            ? String(localized: "filters_articleDomains")
            : String.localizedStringWithFormat(
              NSLocalizedString("filters_articleDomainsCount", comment: ""),
              Int64(activeDomains.count)
            ),
          showsChevron: true,
          isActive: !activeDomains.isEmpty
        ) { showDomainsPicker = true }
        .sheet(isPresented: $showDomainsPicker) {
          MultiSelectPickerView(
            title: String(localized: "filters_articleDomains"),
            items: availableDomains,
            selection: activeDomains
          ) { selected in viewModel.setDomains(selected) }
        }
        .task(id: showDomainsPicker) {
          if showDomainsPicker { availableDomains = await viewModel.fetchAvailableDomains() }
        }
      }
      .padding(.leading, 16)
      .padding(.vertical, 6)
    }
  }

  private func labelForStateFilter(_ state: NavigationStateFilter) -> String {
    switch state {
    case .all: return String(localized: "filters_articleStateAll")
    case .unread: return String(localized: "filters_articleStateUnread")
    case .archived: return String(localized: "filters_articleStateArchived")
    }
  }
}

private struct FilterChipLabel: View {
  let label: String
  var showsChevron: Bool = false
  let isActive: Bool

  var body: some View {
    HStack(spacing: 4) {
      Text(label)
      if showsChevron { Image(systemName: "chevron.down").imageScale(.small) }
    }
    .font(.subheadline)
    .padding(.horizontal, 12)
    .padding(.vertical, 6)
    .background(isActive ? Color.accentColor : Color(.systemGray6))
    .foregroundStyle(isActive ? .white : .primary)
    .clipShape(Capsule())
  }
}

private struct FilterChip: View {
  let label: String
  var showsChevron: Bool = false
  let isActive: Bool
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      FilterChipLabel(label: label, showsChevron: showsChevron, isActive: isActive)
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
      .overlay {
        if items.isEmpty {
          if #available(iOS 17.0, *) {
            ContentUnavailableView(title, systemImage: "tray")
          } else {
            // Fallback on earlier versions
          }
        }
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
