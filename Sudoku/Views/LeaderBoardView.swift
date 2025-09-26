//
//  LeaderBoardView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/15/25.
//

import GameKit
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
    @EnvironmentObject var sudoku: Sudoku
    @State private var isShowingGameCenter = false
    @State private var gamesPlayed = 122
    @State private var perfectGames = 122

    var body: some View {
        NavigationStack {
            Spacer()

            VStack {
                Button {
                    isShowingGameCenter.toggle()
                } label: {
                    Image("GameCenter")
                        .resizable()
                        .frame(width: 50, height: 50)
                }

                // Leaderboard Screen
                HStack {
                    VStack(alignment: .trailing) {
                        Text(String(localized: "high score:"))
                        Text(String(localized: "games played:"))
                        Text(String(localized: "perfect games:"))
                        Text(String(localized: "playtime:"))
                    }
                    VStack(alignment: .leading) {
                        Text("\(sudoku.leaderboard[0].score)")
                            .foregroundStyle(Color.blue)
                        Text("\(gamesPlayed)")
                        Text("\(perfectGames)")
                        Text(
                            String(
                                format: "%02d:%02d",
                                sudoku.leaderboard[0].time / 60,
                                sudoku.leaderboard[0].time % 60
                            )
                        )
                    }
                    .fontWeight(.bold)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(String(localized: "reset")) {
                        // please put action in
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
            BestScoreView(
                level: .easy,
                best: sudoku.leaderboard[Level.easy.rawValue]
            )
            Spacer()
            BestScoreView(
                level: .medium,
                best: sudoku.leaderboard[Level.medium.rawValue]
            )
            Spacer()
            BestScoreView(
                level: .hard,
                best: sudoku.leaderboard[Level.hard.rawValue]
            )
            Spacer()
            Spacer()
        }
        .onAppear {
            loadGameLeaderboards()
        }
        .sheet(isPresented: $isShowingGameCenter) {
            GameCenterView(state: .leaderboards)  // Or .leaderboard for
        }
    }

    func loadGameLeaderboards() {
        guard GKLocalPlayer.local.isAuthenticated else {
            print("Local player not authenticated. Cannot submit score.")
            return
        }

        getLeaderboardData(level: .easy)
        getLeaderboardData(level: .medium)
        getLeaderboardData(level: .hard)
    }

    func getLeaderboardData(level: Level) {
        var leaderboards: [GKLeaderboard] = []

        // Replace with your actual leaderboard IDs from App Store Connect
        let leaderboardIDs = sudoku.score.getLeaderboardIDs(level: level)

        GKLeaderboard.loadLeaderboards(IDs: leaderboardIDs) { loadedboards, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(
                        "Failed to load leaderboards: \(error.localizedDescription)"
                    )
                } else if let loadedLeaderboards = loadedboards {
                    leaderboards = loadedLeaderboards

                    for leaderboard in leaderboards {
                        if let leaderboardTitle = leaderboard.title {
                            if leaderboardTitle
                                == sudoku.score.getLevelLeaderboardTitle(
                                    level: level
                                ) {
                                readLeaderboard(
                                    level: level,
                                    leaderboard: leaderboard,
                                    scoreType: true
                                )
                            } else {
                                readLeaderboard(
                                    level: level,
                                    leaderboard: leaderboard,
                                    scoreType: false
                                )
                            }
                        }

                    }
                }
            }
        }
    }

    func readLeaderboard(
        level: Level,
        leaderboard: GKLeaderboard,
        scoreType: Bool
    ) {
        leaderboard.loadEntries(
            for: .global,
            timeScope: .allTime,
            range: NSRange(location: 1, length: 10)
        ) { localPlayerEntry, entries, _, error in
            if let error = error {
                print(
                    "Error loading entries: \(error.localizedDescription)"
                )
                return
            }

            if scoreType {
                if let localEntry = localPlayerEntry {
                    sudoku.leaderboard[0].score =
                        localEntry.score
                            > sudoku.leaderboard[0].score
                        ? localEntry.score
                        : sudoku.leaderboard[0].score
                }

                if let leader = entries?.first {
                    sudoku.leaderboard[level.rawValue].score =
                        leader.score
                }
            } else {
                if let localEntry = localPlayerEntry {
                    sudoku.leaderboard[0].time =
                        localEntry.score
                            < sudoku.leaderboard[0].time
                        ? localEntry.score
                        : sudoku.leaderboard[0].time
                }

                if let leader = entries?.first {
                    sudoku.leaderboard[level.rawValue].time =
                        leader.score
                }
            }

        }
    }
}

#Preview {
    LeaderBoardView()
        .environmentObject(Sudoku())
}
