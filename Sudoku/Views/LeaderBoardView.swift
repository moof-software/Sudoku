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
    @State private var highScore = 83498
    @State private var gamesPlayed = 122
    @State private var perfectGames = 122
    @State private var playTime = Date.now

    @State private var bestScore = 0
    @State private var bestRun = 0
    @State private var bestTime = Date.now

    var body: some View {
        NavigationStack {
            Spacer()
            VStack {
                // Leaderboard Screen
                HStack {
                    VStack(alignment: .trailing) {
                        Text("high score:")
                        Text("games played:")
                        Text("perfect games:")
                        Text("playtime:")
                    }
                    VStack(alignment: .leading) {
                        Text("\(highScore)")
                            .foregroundStyle(Color.blue)
                        Text("\(gamesPlayed)")
                        Text("\(perfectGames)")
                        Text(
                            playTime,
                            format: .dateTime.hour(.twoDigits(amPM: .omitted))
                                .minute().second()
                        )
                    }
                    .fontWeight(.bold)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("reset") {
                        // please put action in
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
            BestScoreView(
                level: "Easy",
                bestScore: bestScore,
                bestRun: bestRun,
                bestTime: bestTime
            )
            Spacer()
            BestScoreView(
                level: "Medium",
                bestScore: bestScore,
                bestRun: bestRun,
                bestTime: bestTime
            )
            Spacer()
            BestScoreView(
                level: "Hard",
                bestScore: 83498,
                bestRun: 27,
                bestTime: bestTime
            )
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    LeaderBoardView()
}
