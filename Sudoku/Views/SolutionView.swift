//
//  SolutionView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// - Type: Navigation Stack
/// - (임시) 1개의 button을 갖는다
///     - Tile: Home
///     - Action: GameHomeView 열기 또는 dismiss()
struct SolutionView: View {

    @State private var solutionBoardText = "Board"

    var body: some View {
        VStack {
            Spacer()
            Text(solutionBoardText)
                .frame(maxWidth: .infinity, maxHeight: 500)
                .background(Color.gray.opacity(0.2))
            Button("Solve it!") {
                solutionBoardText = "Solved!"
            }
            .buttonStyle(.bordered)
            Spacer()
            Button("Home") {
                // Connect to GameHomeView
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    SolutionView()
}
