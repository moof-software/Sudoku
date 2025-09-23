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

struct LeaderBoardView: UIViewControllerRepresentable {
    let gameCenterViewControllerState: GKGameCenterViewControllerState?

    func makeUIViewController(context: Context) -> GKGameCenterViewController {
        let vc = GKGameCenterViewController(
            state: gameCenterViewControllerState ?? .default
        )
        return vc
    }

    func updateUIViewController(
        _ uiViewController: GKGameCenterViewController,
        context: Context
    ) {
        // Update the view controller if needed, e.g., changing the state
        // uiViewController.setViewControllerState(gameCenterViewControllerState, animated: false)
    }
    //    @State private var highScore = 83498
    //    @State private var gamesPlayed = 122
    //    @State private var perfectGames = 122
    //    @State private var playTime = Date.now
    //
    //    @State private var bestScore = 0
    //    @State private var bestRun = 0
    //    @State private var bestTime = Date.now
    //
    //    var body: some View {
    //        NavigationStack {
    //            Spacer()
    ////            if leaderboards.count != 0 {
    ////                List(leaderboards, id: \.self) { leaderboard in
    ////                    VStack(alignment: .leading) {
    ////                        Text(leaderboard.title ?? "Unknown Leaderboard")
    ////                            .font(.headline)
    ////                        Text("Identifier: \(leaderboard.description)")
    ////                            .font(.subheadline)
    ////                    }
    ////                }
    ////            }
    //            VStack {
    //                // Leaderboard Screen
    //                HStack {
    //                    VStack(alignment: .trailing) {
    //                        Text(String(localized: "high score:"))
    //                        Text(String(localized: "games played:"))
    //                        Text(String(localized: "perfect games:"))
    //                        Text(String(localized: "playtime:"))
    //                    }
    //                    VStack(alignment: .leading) {
    //                        Text("\(highScore)")
    //                            .foregroundStyle(Color.blue)
    //                        Text("\(gamesPlayed)")
    //                        Text("\(perfectGames)")
    //                        Text(
    //                            playTime,
    //                            format: .dateTime.hour(.twoDigits(amPM: .omitted))
    //                                .minute().second()
    //                        )
    //                    }
    //                    .fontWeight(.bold)
    //                }
    //            }
    //            .toolbar {
    //                ToolbarItem(placement: .topBarTrailing) {
    //                    Button(String(localized: "reset")) {
    //                        // please put action in
    //                    }
    //                    .padding(.horizontal)
    //                }
    //            }
    //            Spacer()
    //            BestScoreView(
    //                level: String(localized: "Easy"),
    //                bestScore: bestScore,
    //                bestRun: bestRun,
    //                bestTime: bestTime
    //            )
    //            Spacer()
    //            BestScoreView(
    //                level: String(localized: "Medium"),
    //                bestScore: bestScore,
    //                bestRun: bestRun,
    //                bestTime: bestTime
    //            )
    //            Spacer()
    //            BestScoreView(
    //                level: String(localized: "Hard"),
    //                bestScore: 83498,
    //                bestRun: 27,
    //                bestTime: bestTime
    //            )
    //            Spacer()
    //            Spacer()
    //        }
    //        .onAppear {
    //            loadGameLeaderboards()
    //        }
    //    }
    //
    //    func loadGameLeaderboards() {
    //        var leaderboards: [GKLeaderboard] = []
    //        let localPlayer = GKLocalPlayer.local
    //        // Replace with your actual leaderboard IDs from App Store Connect
    //        let leaderboardIDs = ["sudokupro.leaderboard.highest.score", "sudokupro.leaderboard.fastest.time"]
    //
    //        guard GKLocalPlayer.local.isAuthenticated else {
    //            print("Local player not authenticated. Cannot submit score.")
    //            return
    //        }
    //
    //        GKLeaderboard.loadLeaderboards(IDs: leaderboardIDs) { loadedLeaderboards, error in
    //            DispatchQueue.main.async {
    //                if let error = error {
    //                    print("Failed to load leaderboards: \(error.localizedDescription)")
    //                } else if let loadedLeaderboards = loadedLeaderboards {
    //                    leaderboards = loadedLeaderboards
    //                    print("Leaderboards loaded successfully: \(loadedLeaderboards.count)")
    //
    //                    if leaderboards.count != 0 {
    //                        for leaderboard in leaderboards {
    //                            leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(location: 1, length: 10)) { localPlayerEntry, entries, totalPlayerCount, error in
    //                                if let error = error {
    //                                    print("Error loading entries: \(error.localizedDescription)")
    //                                    return
    //                                }
    //
    //                                if let localEntry = localPlayerEntry {
    //                                    print("Local player score: \(localEntry.score)")
    //                                }
    //
    //                                if let leaderboardEntries = entries {
    //                                    for entry in leaderboardEntries {
    //                                        print("Player: \(entry.player.displayName), Score: \(entry.score), Rank: \(entry.rank)")
    //                                    }
    //                                }
    //                            }
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
}

#Preview {
    LeaderBoardView(gameCenterViewControllerState: .leaderboards)
}
