//
//  SolutionView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// View that provides an empty or partially filled Sudoku board that can be solved with a button.
///
/// Contains:
///
/// - VStack
///     - `solutionBoardText` Text
///         - Default must be "Board"
///     - Solve It Button
///         - Label: "Solve it!"
///         - Action: Changes `solutionBoardText` to "Solved"
///     - Home Button
///         - Label: "Home"
///         - Action: Connect to GameHomeView
struct SolutionView: View {

    @State private var solutionBoardText = "Board"

    var body: some View {
        VStack {
            Spacer()
            Text(solutionBoardText)
                .frame(maxWidth: .infinity, maxHeight: 500)
                .background(Color.gray.opacity(0.2))
            Button("Solve it!") {
                // Changes board text
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
