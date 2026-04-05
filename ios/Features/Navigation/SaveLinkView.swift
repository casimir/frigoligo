import SwiftUI

struct SaveLinkView: View {
  @EnvironmentObject var viewModel: NavigationSplitViewModel
  @Environment(\.dismiss) private var dismiss
  @State private var url = ""
  @State private var isSaving = false
  @State private var errorMessage: String?

  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("https://", text: $url)
            .keyboardType(.URL)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
        }
        if let error = errorMessage {
          Section {
            Text(error).foregroundStyle(.red)
          }
        }
      }
      .navigationTitle("Save link")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") { dismiss() }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("Save") { save() }
            .disabled(url.isEmpty || isSaving)
        }
      }
      .overlay {
        if isSaving { ProgressView() }
      }
      .disabled(isSaving)
    }
  }

  private func save() {
    isSaving = true
    errorMessage = nil
    Task {
      do {
        try await viewModel.saveLink(url: url)
        await MainActor.run { dismiss() }
      } catch {
        await MainActor.run {
          errorMessage = error.localizedDescription
          isSaving = false
        }
      }
    }
  }
}
