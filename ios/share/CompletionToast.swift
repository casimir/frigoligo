//
//  CompletionToast.swift
//  share
//
//  Created by Martin Chaine on 25/09/2023.
//

import SwiftUI

public enum CompletionError: Error {
    case description(String)
}

public enum CompletionState {
    case pending, success
}

class ToastViewModel: ObservableObject {
    @Published var state: CompletionState = .pending
}

public struct CompletionToast: View {
    let frameSize = 100.0
    let frameColor = Color.secondary.opacity(1.0)
    
    @ObservedObject var vm: ToastViewModel
    let action: () async throws -> Void
    let didSucceed: () async -> Void
    let onError: (String) async -> Void
    let strokeColor: Color
    
    @State private var animValue: CGFloat = .zero

    public var body: some View {
        switch vm.state {
        case .pending:
            ProgressView()
                .frame(width: frameSize, height: frameSize)
                .background(frameColor)
                .cornerRadius(20)
                .task {
                    do {
                        try await action()
                        vm.state = .success
                    } catch CompletionError.description(let message) {
                        await onError(message)
                    } catch {
                        await onError("error unexpected: \(error)")
                    }
                }
        case .success:
            let size = frameSize / 2
            Path { path in
                path.move(to: CGPoint(x: size * 0.5, y: size))
                path.addLine(to: CGPoint(x: size * 0.9, y: size * 1.5))
                path.addLine(to: CGPoint(x: size * 1.5, y: size * 0.5))
            }
            .trim(from: 0, to: animValue)
            .stroke(strokeColor, style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
            .animation(.easeInOut, value: animValue)
            .onAppear { animValue = 1.0 }
            .frame(width: frameSize, height: frameSize)
            .background(frameColor)
            .cornerRadius(20)
            .task {
                do {
                    // leave the success feedback sink in the user mind
                    try await Task.sleep(nanoseconds: 600_000_000)
                } catch {
                    devLog("task: couldn't wait a bit: \(error)")
                }
                await didSucceed()
            }
        }
    }
}
