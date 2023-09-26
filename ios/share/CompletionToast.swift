//
//  CompletionToast.swift
//  share
//
//  Created by Martin Chaine on 25/09/2023.
//

import SwiftUI

public enum CompletionState {
    case pending, success
}

class ToastViewModel: ObservableObject {
    @Published var state: CompletionState = .pending
}

public struct CompletionToast: View {
    let frameSize = 100.0
    let frameColor = Color.secondary.opacity(1.0)
    
    @ObservedObject var viewModel: ToastViewModel
    let strokeColor: Color
    
    @State private var animValue: CGFloat = .zero

    public var body: some View {
        switch viewModel.state {
        case .pending:
            ProgressView()
                .frame(width: frameSize, height: frameSize)
                .background(frameColor)
                .cornerRadius(20)
        case .success:
            let size = frameSize / 2
            Path { path in
                path.move(to: CGPoint(x: size * 0.5, y: size))
                path.addLine(to: CGPoint(x: size * 0.9, y: size * 1.5))
                path.addLine(to: CGPoint(x: size * 1.5, y: size * 0.5))
            }
            .trim(from: 0, to: animValue)
            .stroke(strokeColor, style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
            .animation(.easeInOut.delay(0.2), value: animValue)
            .onAppear { animValue = 1.0 }
            .frame(width: frameSize, height: frameSize)
            .background(frameColor)
            .cornerRadius(20)
        }
    }
}
