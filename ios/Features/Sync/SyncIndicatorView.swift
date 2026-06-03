import Flutter
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
  @EnvironmentObject var navViewModel: NavigationSplitViewModel
  @Environment(\.horizontalSizeClass) private var sizeClass
  @State private var showDetail = false

  private var state: SyncIndicatorState { syncViewModel.syncState }

  var body: some View {
    if state.status != .allGood {
      Button {
        showDetail = true
      } label: {
        indicatorLabel
      }
      .popover(isPresented: $showDetail) {
        SyncDetailView()
          .environmentObject(syncViewModel)
          .environmentObject(navViewModel)
          .presentationDetents(sizeClass == .compact ? [.medium] : [])
      }
      .onDisappear { showDetail = false }
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
    VStack(alignment: .leading, spacing: 16) {
      HStack(alignment: .center, spacing: 10) {
        statusIcon
          .font(.title3)
        Text(statusDescription)
          .font(.headline)
      }

      if state.status == .syncing {
        if let progress = state.progressValue {
          ProgressView(value: progress).progressViewStyle(.linear)
        } else {
          ProgressView().progressViewStyle(.linear)
        }
      }

      Divider()

      VStack(alignment: .leading, spacing: 6) {
        Text(lastSyncText)
          .font(.subheadline)
          .foregroundStyle(.secondary)

        if state.pendingCount > 0 {
          Text(String(format: String(localized: "sync_pendingCount"), state.pendingCount))
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
      }

      if let errorDetail = state.errorDetail {
        Text(errorDetail)
          .font(.caption.monospaced())
          .foregroundStyle(.secondary)
          .padding(8)
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(.quaternary, in: RoundedRectangle(cornerRadius: 6))
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

  @ViewBuilder
  private var statusIcon: some View {
    switch state.status {
    case .allGood:
      Image(systemName: "checkmark.circle.fill")
        .foregroundStyle(.green)
    case .syncing:
      Image(systemName: "arrow.triangle.2.circlepath")
        .modifier(SpinningModifier())
    case .noInternet:
      Image(systemName: "wifi.slash")
        .foregroundStyle(.orange)
    case .serverUnreachable, .syncError:
      Image(systemName: "exclamationmark.triangle.fill")
        .foregroundStyle(.orange)
    case .authFailure:
      Image(systemName: "person.crop.circle.badge.exclamationmark")
        .foregroundStyle(.red)
    }
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

private class PreviewBinaryMessenger: NSObject, FlutterBinaryMessenger {
  func send(onChannel channel: String, message: Data?) {}
  func send(
    onChannel channel: String,
    message: Data?,
    binaryReply callback: FlutterBinaryReply?
  ) {}
  func setMessageHandlerOnChannel(
    _ channel: String,
    binaryMessageHandler handler: FlutterBinaryMessageHandler?
  ) -> FlutterBinaryMessengerConnection { 0 }
  func cleanUpConnection(_ connection: FlutterBinaryMessengerConnection) {}
}

@MainActor
private func previewSyncVM(
  status: SyncIndicatorStatus,
  progressValue: Double? = nil,
  pendingCount: Int64 = 0,
  lastSyncTimestamp: Int64? = nil,
  errorDetail: String? = nil
) -> SyncViewModel {
  let vm = SyncViewModel(binaryMessenger: PreviewBinaryMessenger())
  vm.syncState = SyncIndicatorState(
    status: status,
    progressValue: progressValue,
    pendingCount: pendingCount,
    lastSyncTimestamp: lastSyncTimestamp,
    errorDetail: errorDetail
  )
  return vm
}

#Preview("Indicator icons") {
  let navVM = NavigationSplitViewModel(binaryMessenger: PreviewBinaryMessenger())
  VStack(spacing: 16) {
    HStack {
      Text("syncing (indeterminate)")
      Spacer()
      SyncIndicatorView().environmentObject(previewSyncVM(status: .syncing))
    }
    HStack {
      Text("syncing (determinate)")
      Spacer()
      SyncIndicatorView().environmentObject(previewSyncVM(status: .syncing, progressValue: 0.6))
    }
    HStack {
      Text("syncError + pending")
      Spacer()
      SyncIndicatorView().environmentObject(previewSyncVM(status: .syncError, pendingCount: 3))
    }
    HStack {
      Text("noInternet")
      Spacer()
      SyncIndicatorView().environmentObject(previewSyncVM(status: .noInternet))
    }
    HStack {
      Text("serverUnreachable")
      Spacer()
      SyncIndicatorView().environmentObject(previewSyncVM(status: .serverUnreachable))
    }
    HStack {
      Text("syncError")
      Spacer()
      SyncIndicatorView().environmentObject(previewSyncVM(status: .syncError))
    }
    HStack {
      Text("authFailure")
      Spacer()
      SyncIndicatorView().environmentObject(previewSyncVM(status: .authFailure))
    }
  }
  .padding()
  .environmentObject(navVM)
}

#Preview("Detail view") {
  let navVM = NavigationSplitViewModel(binaryMessenger: PreviewBinaryMessenger())
  let ts = Int64(Date().timeIntervalSince1970) - 3600
  ScrollView {
    VStack(alignment: .leading, spacing: 24) {
      Text("syncing, indeterminate").font(.caption).foregroundStyle(.secondary)
      SyncDetailView().environmentObject(previewSyncVM(status: .syncing))

      Text("syncing, determinate (60%)").font(.caption).foregroundStyle(.secondary)
      SyncDetailView().environmentObject(previewSyncVM(status: .syncing, progressValue: 0.6))

      Text("syncing + pending").font(.caption).foregroundStyle(.secondary)
      SyncDetailView()
        .environmentObject(previewSyncVM(status: .syncing, pendingCount: 3, lastSyncTimestamp: ts))

      Text("noInternet, never synced").font(.caption).foregroundStyle(.secondary)
      SyncDetailView().environmentObject(previewSyncVM(status: .noInternet))

      Text("noInternet + last sync").font(.caption).foregroundStyle(.secondary)
      SyncDetailView()
        .environmentObject(previewSyncVM(status: .noInternet, lastSyncTimestamp: ts))

      Text("serverUnreachable + error").font(.caption).foregroundStyle(.secondary)
      SyncDetailView()
        .environmentObject(
          previewSyncVM(
            status: .serverUnreachable, lastSyncTimestamp: ts, errorDetail: "Connection refused"))

      Text("syncError + pending + error").font(.caption).foregroundStyle(.secondary)
      SyncDetailView()
        .environmentObject(
          previewSyncVM(
            status: .syncError, pendingCount: 3, lastSyncTimestamp: ts, errorDetail: "HTTP 500"))

      Text("authFailure").font(.caption).foregroundStyle(.secondary)
      SyncDetailView()
        .environmentObject(previewSyncVM(status: .authFailure, lastSyncTimestamp: ts))
    }
    .padding()
  }
  .environmentObject(navVM)
}
