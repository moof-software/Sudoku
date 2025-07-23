//
//  LeaderBoardView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/15/25.
//

import SwiftUI

/// View that shows user's current rankings
///
/// Contains:
/// - VStack
///     - HStack
///         - Back Button
///             - Label: "< Back"
///             - Action: Connect to GameHomeView
///         - Clear Button
///             - Label: "Clear"
///             - Action: Change `displayedText` to "Cleared"
///     - `displayedText` Text
///         - Default must be "Leaderboard Screen"

struct LeaderBoardView: View {
    @State private var displayedText = "Leaderboard Screen"

    var body: some View {
        VStack {
            HStack {
                Spacer()
                // Clear Button
                Button("Clear") {
                    // Change text from "Leaderboard Screen" to "Cleared"
                    displayedText = "Cleared"
                }
                .padding()
            }
            Spacer()
            // Leaderboard Screen
            Text(displayedText)
            Spacer()
        }
    }
}

#Preview {
    LeaderBoardView()
}
