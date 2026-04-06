import OSLog
import SwiftUI

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "LogConsole")

private struct LogExport: Identifiable {
  let id = UUID()
  let content: String
}

private struct ActivitySheet: UIViewControllerRepresentable {
  let content: String

  func makeUIViewController(context: Context) -> UIActivityViewController {
    let url = FileManager.default.temporaryDirectory.appendingPathComponent("frigoligo.log")
    do {
      try content.write(to: url, atomically: true, encoding: .utf8)
    } catch {
      logger.error("Failed to write log export: \(error)")
    }
    return UIActivityViewController(activityItems: [url], applicationActivities: nil)
  }

  func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct LogConsoleView: View {
  @EnvironmentObject var viewModel: LogConsoleViewModel
  @Environment(\.dismiss) private var dismiss
  @State private var currentRunEntries: [NativeLogEntry] = []
  @State private var allEntries: [NativeLogEntry] = []
  @State private var showExportDialog = false
  @State private var pendingExport: LogExport?

  var body: some View {
    List {
      ForEach(Array(currentRunEntries.enumerated()), id: \.offset) { _, entry in
        Text(formatEntry(entry))
          .font(.system(.caption2, design: .monospaced))
          .foregroundStyle(color(for: entry.level))
          .listRowInsets(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8))
      }
    }
    .listStyle(.plain)
    .navigationTitle(String(localized: "logconsole_title"))
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          Task {
            let all = await viewModel.getLogs(onlyCurrentRun: false)
            allEntries = all
            if currentRunEntries.isEmpty {
              pendingExport = LogExport(content: all.map(formatEntry).joined(separator: "\n"))
            } else {
              showExportDialog = true
            }
          }
        } label: {
          Image(systemName: "square.and.arrow.up")
        }
        .confirmationDialog(
          String(localized: "logconsole_export_title"),
          isPresented: $showExportDialog,
          titleVisibility: .visible
        ) {
          Button(
            String.localizedStringWithFormat(
              NSLocalizedString("logconsole_export_current_session", comment: ""),
              currentRunEntries.count)
          ) {
            pendingExport = LogExport(
              content: currentRunEntries.map(formatEntry).joined(separator: "\n"))
          }
          Button(
            String.localizedStringWithFormat(
              NSLocalizedString("logconsole_export_all_logs", comment: ""), allEntries.count)
          ) {
            pendingExport = LogExport(content: allEntries.map(formatEntry).joined(separator: "\n"))
          }
        }
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(role: .destructive) {
          viewModel.clearLogs()
          dismiss()
        } label: {
          Image(systemName: "trash")
        }
      }
    }
    .sheet(item: $pendingExport) { export in
      ActivitySheet(content: export.content)
    }
    .task {
      currentRunEntries = await viewModel.getLogs(onlyCurrentRun: true)
    }
  }

  private func formatEntry(_ entry: NativeLogEntry) -> String {
    var line = "[\(entry.time) \(entry.level) \(entry.loggerName)] \(entry.message)"
    if let error = entry.error {
      line += " (\(error))"
    }
    return line
  }

  private func color(for level: String) -> Color {
    switch level.uppercased() {
    case "SEVERE", "WARNING": .orange
    case "FINE", "FINEST", "FINER": .secondary
    default: .primary
    }
  }
}
