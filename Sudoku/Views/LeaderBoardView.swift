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
    @State private var gamesPlayed = 122
    @State private var perfectGames = 122

    @State var leaderboard: [RecordedBest] = [
        RecordedBest(score: 0, run: 0, time: 0),
        RecordedBest(score: 0, run: 0, time: 0),
        RecordedBest(score: 0, run: 0, time: 0),
        RecordedBest(score: 0, run: 0, time: 0)
    ]

    var body: some View {
        NavigationStack {
            Spacer()
            VStack {
                // Leaderboard Screen
                HStack {
                    VStack(alignment: .trailing) {
                        Text(String(localized: "high score:"))
                        Text(String(localized: "games played:"))
                        Text(String(localized: "perfect games:"))
                        Text(String(localized: "playtime:"))
                    }
                    VStack(alignment: .leading) {
                        Text("\(leaderboard[0].score)")
                            .foregroundStyle(Color.blue)
                        Text("\(gamesPlayed)")
                        Text("\(perfectGames)")
                        Text(
                            String(
                                format: "%02d:%02d",
                                leaderboard[0].time / 60,
                                leaderboard[0].time % 60
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
                best: leaderboard[Level.easy.rawValue]
            )
            Spacer()
            BestScoreView(
                level: .medium,
                best: leaderboard[Level.medium.rawValue]
            )
            Spacer()
            BestScoreView(
                level: .hard,
                best: leaderboard[Level.hard.rawValue]
            )
            Spacer()
            Spacer()
        }
        .onAppear {
            loadGameLeaderboards()
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
        var levelString: String = ""
        var levelLeaderboardTitle: String = ""

        switch level {
        case .medium:
            levelString = "mediumlevel"
            levelLeaderboardTitle = "MediumLevelScore"
        case .hard:
            levelString = "hardlevel"
            levelLeaderboardTitle = "HardLevelScore"
        default:
            levelString = "easylevel"
            levelLeaderboardTitle = "EasyLevelScore"
        }
        // Replace with your actual leaderboard IDs from App Store Connect
        let leaderboardIDs = [
            "sudokupro." + levelString + ".leaderboard.score",
            "sudokupro." + levelString + ".leaderboard.time",
        ]

        GKLeaderboard.loadLeaderboards(IDs: leaderboardIDs) {
            loadedboards,
            error in
            DispatchQueue.main.async {
                if let error = error {
                    print(
                        "Failed to load leaderboards: \(error.localizedDescription)"
                    )
                } else if let loadedLeaderboards = loadedboards {
                    leaderboards = loadedLeaderboards

                    for leaderboard in leaderboards {
                        if let leaderboardTitle = leaderboard.title {
                            if leaderboardTitle == levelLeaderboardTitle {
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
                    self.leaderboard[0].score =
                        localEntry.score
                            > self.leaderboard[0].score
                        ? localEntry.score
                        : self.leaderboard[0].score
                }

                if let leader = entries?.first {
                    self.leaderboard[level.rawValue].score =
                        leader.score
                }
            } else {
                if let localEntry = localPlayerEntry {
                    self.leaderboard[0].time =
                        localEntry.score
                            < self.leaderboard[0].time
                        ? localEntry.score
                        : self.leaderboard[0].time
                }

                if let leader = entries?.first {
                    self.leaderboard[level.rawValue].time =
                        leader.score
                }
            }

        }
    }

    //    func readEntries(
    //        level: Level,
    //        scoreType: Bool,
    //        localPlayer: GKLeaderboard.Entry?,
    //        entries: [GKLeaderboard.Entry]
    //    ) {
    //        if scoreType {
    //            if let localEntry = localPlayer {
    //                self.leaderboard[0].score =
    //                    localEntry.score
    //                        > self.leaderboard[0].score
    //                    ? localEntry.score
    //                    : self.leaderboard[0].score
    //            }
    //
    //            if let leader = entries.first {
    //                self.leaderboard[level.rawValue].score =
    //                    leader.score
    //            }
    //        } else {
    //            if let localEntry = localPlayer {
    //                self.leaderboard[0].time =
    //                    localEntry.score
    //                        < self.leaderboard[0].time
    //                    ? localEntry.score
    //                    : self.leaderboard[0].time
    //            }
    //
    //            if let leader = entries.first {
    //                self.leaderboard[level.rawValue].time =
    //                    leader.score
    //            }
    //        }
    //
    //    }
}

#Preview {
    LeaderBoardView()
}
//
//{
//    let gameCenterViewControllerState: GKGameCenterViewControllerState?
//
//    func makeUIViewController(context: Context) -> GKGameCenterViewController {
//        let vc = GKGameCenterViewController(
//            state: gameCenterViewControllerState ?? .default
//        )
//        return vc
//    }
//
//    func updateUIViewController(
//        _ uiViewController: GKGameCenterViewController,
//        context: Context
//    ) {
//        // Update the view controller if needed, e.g., changing the state
//        // uiViewController.setViewControllerState(gameCenterViewControllerState, animated: false)
//    }
//}
