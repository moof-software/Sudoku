//
//  ScoreView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// View that shows the final scores.
///
/// Contains:
/// - VStack
///     - "Final Score" Text
///     - "Scores:" Text
///     - Home Button
///         - Label: "Home"
///         - Action: Connect to GameHomeView
struct ScoreView: View {
    var body: some View {
        VStack {
            Text("Final Score")
                .font(.title)
                .bold()
            Spacer()
            Text("Scores:")
            Spacer()
            Button("Home") {
                // Connect to GameHomeView
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ScoreView()
}
