import SwiftUI

private struct SpinningModifier: ViewModifier {
  @State private var angle: Double = 0

  func body(content: Content) -> some View {
    if #available(iOS 18, *) {
      content.symbolEffect(.rotate, isActive: true)
    } else {
      content
        .rotationEffect(.degrees(angle))
        .onAppear {
          withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
            angle = 360
          }
        }
    }
  }
}

struct SyncIndicatorView: View {
  @EnvironmentObject var syncViewModel: SyncViewModel
  @Environment(\.horizontalSizeClass) private var sizeClass
  @State private var showDetail = false

  private var state: SyncIndicatorState { syncViewModel.syncState }

  var body: some View {
    if state.status != .allGood {
      Button {
        showDetail = true
      } label: {
        indicatorLabel
          .overlay(alignment: .topTrailing) {
            if state.pendingCount > 0 {
              Text("\(state.pendingCount)")
                .font(.caption2)
                .bold()
                .foregroundStyle(.white)
                .padding(2)
                .background(.red, in: Circle())
                .offset(x: 6, y: -6)
            }
          }
      }
      .popover(isPresented: $showDetail) {
        SyncDetailView()
          .environmentObject(syncViewModel)
          .presentationDetents(sizeClass == .compact ? [.medium] : [])
      }
    }
  }

  @ViewBuilder
  private var indicatorLabel: some View {
    switch state.status {
    case .syncing:
      Image(systemName: "arrow.triangle.2.circlepath")
        .modifier(SpinningModifier())
    case .noInternet:
      Image(systemName: "wifi.slash")
        .foregroundStyle(.orange)
    case .serverUnreachable, .syncError:
      Image(systemName: "exclamationmark.triangle")
        .foregroundStyle(.orange)
    case .authFailure:
      Image(systemName: "person.crop.circle.badge.exclamationmark")
        .foregroundStyle(.red)
    case .allGood:
      EmptyView()
    }
  }
}

struct SyncDetailView: View {
  @EnvironmentObject var syncViewModel: SyncViewModel
  @EnvironmentObject var navViewModel: NavigationSplitViewModel

  private var state: SyncIndicatorState { syncViewModel.syncState }

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(statusDescription)
        .font(.headline)

      Text(lastSyncText)
        .font(.subheadline)
        .foregroundStyle(.secondary)

      if state.pendingCount > 0 {
        Text(String(format: String(localized: "%@ pending"), "\(state.pendingCount)"))
          .font(.subheadline)
          .foregroundStyle(.secondary)
      }

      if let errorDetail = state.errorDetail {
        Text(errorDetail)
          .font(.caption)
          .foregroundStyle(.secondary)
      }

      switch state.status {
      case .serverUnreachable, .syncError:
        Button(String(localized: "sync_retry")) {
          Task { await navViewModel.refresh() }
        }
        .buttonStyle(.borderedProminent)
      case .authFailure:
        Button(String(localized: "sync_openSettings")) {
          navViewModel.openSettings()
        }
        .buttonStyle(.borderedProminent)
      case .allGood, .syncing, .noInternet:
        EmptyView()
      }
    }
    .padding()
    .frame(minWidth: 260, alignment: .leading)
  }

  private var statusDescription: String {
    switch state.status {
    case .allGood: return String(localized: "sync_statusAllGood")
    case .syncing: return String(localized: "sync_statusSyncing")
    case .noInternet: return String(localized: "sync_statusNoInternet")
    case .serverUnreachable: return String(localized: "sync_statusServerUnreachable")
    case .syncError: return String(localized: "sync_statusError")
    case .authFailure: return String(localized: "sync_statusAuthFailure")
    }
  }

  private var lastSyncText: String {
    guard let ts = state.lastSyncTimestamp else {
      return String(localized: "sync_neverSynced")
    }
    let date = Date(timeIntervalSince1970: TimeInterval(ts))
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    let relativeTime = formatter.localizedString(for: date, relativeTo: Date())
    return String(format: String(localized: "sync_lastSynced"), relativeTime)
  }
}
