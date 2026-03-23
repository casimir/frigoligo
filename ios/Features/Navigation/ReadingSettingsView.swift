import SwiftUI

extension ArticleReadingSettings {
  fileprivate func with(
    fontSize: Double? = nil, fontFamily: String? = nil, justifyText: Bool? = nil
  ) -> ArticleReadingSettings {
    ArticleReadingSettings(
      fontSize: fontSize ?? self.fontSize,
      fontFamily: fontFamily ?? self.fontFamily,
      justifyText: justifyText ?? self.justifyText
    )
  }
}

struct ReadingSettingsView: View {
  @EnvironmentObject var viewModel: NavigationSplitViewModel

  private let fontSizes: [Double] = [12, 14, 16, 18, 20]
  private let fontFamilies = [
    "Lato", "Montserrat", "Literata", "Newsreader", "Atkinson Hyperlegible",
  ]

  var body: some View {
    controls
  }

  private var controls: some View {
    VStack(spacing: 16) {
      Text(String(localized: "readingsettings_title"))
        .font(.headline)

      Picker(
        String(localized: "readingsettings_fontSize"),
        selection: binding(\.fontSize, with: { $0.with(fontSize: $1) })
      ) {
        ForEach(fontSizes, id: \.self) { size in
          Text("\(Int(size))").tag(size)
        }
      }
      .pickerStyle(.segmented)

      LabeledContent(String(localized: "readingsettings_fontFamily")) {
        Picker("", selection: binding(\.fontFamily, with: { $0.with(fontFamily: $1) })) {
          ForEach(fontFamilies, id: \.self) { font in
            Text(font).tag(font)
          }
        }
        .pickerStyle(.menu)
      }

      Toggle(
        String(localized: "readdingsettings_textFormatting"),
        isOn: binding(\.justifyText, with: { $0.with(justifyText: $1) }))
    }
    .padding()
    .presentationDetents([.height(210)])
    .presentationDragIndicator(.visible)
  }

  private func binding<T>(
    _ keyPath: KeyPath<ArticleReadingSettings, T>,
    with update: @escaping (ArticleReadingSettings, T) -> ArticleReadingSettings
  ) -> Binding<T> {
    Binding(
      get: { viewModel.readingSettings[keyPath: keyPath] },
      set: {
        viewModel.flutterApi.setReadingSettings(settings: update(viewModel.readingSettings, $0)) {
          _ in
        }
      }
    )
  }
}
