//
//  GameCenterManager.swift
//  Sudoku
//
//  Created by Hungu Lim on 9/27/25.
//

import Foundation
import GameKit
import SwiftUI

class GameCenterManager {
    static let instance = GameCenterManager()

    var localPlayer = GKLocalPlayer.local

    private init() {

    }

    func getLeaderboardIDs(level: Level) -> [String] {
        var levelString: String = ""
        switch level {
        case .medium:
            levelString = "mediumlevel"
        case .hard:
            levelString = "hardlevel"
        default:
            levelString = "easylevel"
        }
        return [
            "sudokupro." + levelString + ".leaderboard.score",
            "sudokupro." + levelString + ".leaderboard.time",
        ]
    }

    func getLevelLeaderboardTitle(level: Level) -> String {
        var titleString: String = ""
        switch level {
        case .medium:
            titleString = "MediumLevelScore"
        case .hard:
            titleString = "HardLevelScore"
        default:
            titleString = "EasyLevelScore"
        }
        return titleString
    }

    func authenticateGameCenter() {
        localPlayer.authenticateHandler = { _, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            print("\(GKLocalPlayer.local.alias) is ready to play!")
        }
    }

    func submitScoreToGameCenter(score: ScoreElements) {
        let localPlayer = GKLocalPlayer.local
        let leaderboardIDs = getLeaderboardIDs(level: score.level)

        guard GKLocalPlayer.local.isAuthenticated else {
            print("Local player not authenticated. Cannot submit score.")
            return
        }
        // Submit score
        GKLeaderboard.submitScore(
            score.total,
            context: 0,
            player: localPlayer,
            leaderboardIDs: [leaderboardIDs[0]]
        ) { error in
            if let error = error {
                print("Error submitting score: \(error.localizedDescription)")
            } else {
                print("Score submitted successfully!")
            }
        }
    }

    func submitTimeToGameCenter(score: ScoreElements) {
        let localPlayer = GKLocalPlayer.local
        let leaderboardIDs = getLeaderboardIDs(level: score.level)
        guard GKLocalPlayer.local.isAuthenticated else {
            print("Local player not authenticated. Cannot submit time.")
            return
        }
        // Submit time
        GKLeaderboard.submitScore(
            score.playtime,
            context: 0,
            player: localPlayer,
            leaderboardIDs: [leaderboardIDs[1]]
        ) { error in
            if let error = error {
                print("Error submitting time: \(error.localizedDescription)")
            } else {
                print("Time submitted successfully!")
            }
        }
    }

    func loadGameLeaderboards() async -> [RecordedBest] {
        var bestScore: [RecordedBest] = [
            RecordedBest(score: 0, run: 0, time: 900),
            RecordedBest(score: 0, run: 0, time: 300),
            RecordedBest(score: 0, run: 0, time: 600),
            RecordedBest(score: 0, run: 0, time: 900),
        ]

        guard localPlayer.isAuthenticated else {
            print("Local player not authenticated. Cannot submit score.")
            return bestScore
        }

        bestScore.insert(
            await getLeaderboardData(level: .player),
            at: Level.player.rawValue
        )
        bestScore.insert(
            await getLeaderboardData(level: .easy),
            at: Level.easy.rawValue
        )
        bestScore.insert(
            await getLeaderboardData(level: .medium),
            at: Level.medium.rawValue
        )
        bestScore.insert(
            await getLeaderboardData(level: .hard),
            at: Level.hard.rawValue
        )

        return bestScore
    }

    func getLeaderboardData(level: Level) async -> RecordedBest {
        //var leaderboards: [GKLeaderboard] = []
        var readerboardData: RecordedBest = RecordedBest(
            score: 0,
            run: 0,
            time: 900
        )
        // Replace with your actual leaderboard IDs from App Store Connect
        let leaderboardIDs = getLeaderboardIDs(level: level)

        do {
            // Load the specific leaderboard
            let loadedboards = try await GKLeaderboard.loadLeaderboards(
                IDs: leaderboardIDs
            )

            if let leaderboard = loadedboards.first {
                for leaderboard in loadedboards {
                    print(
                        "Leaderboard Tile: \(leaderboard.title ?? "None" )"
                    )
                    let (localPlayerEntry, entries, _) =
                        try await leaderboard.loadEntries(
                            for: .global,
                            timeScope: .allTime,
                            range: NSRange(location: 1, length: 10)  // Ranks 1-100
                        )

                    if let leaderboardTitle = leaderboard.title {
                        if leaderboardTitle
                            == self.getLevelLeaderboardTitle(level: level)
                        {
                            if level == .player {
                                if let localEntry = localPlayerEntry {
                                    readerboardData.score = localEntry.score
                                    print(
                                        "Local Player Score: \(localEntry.score), Rank: \(localEntry.rank)"
                                    )
                                }
                            } else {
                                if let leader = entries.first {

                                    readerboardData.score = leader.score
                                    print(
                                        "Player: \(leader.player.displayName), Score: \(leader.score), Rank: \(leader.rank)"
                                    )
                                }
                            }
                        } else {
                            if level == .player {
                                if let localEntry = localPlayerEntry {
                                    readerboardData.time = localEntry.score
                                    print(
                                        "Local Player Time: \(localEntry.score), Rank: \(localEntry.rank)"
                                    )
                                }
                            } else {
                                if let leader = entries.first {
                                    readerboardData.time = leader.score
                                    print(
                                        "Player: \(leader.player.displayName), Time: \(leader.score), Rank: \(leader.rank)"
                                    )
                                }
                            }
                        }
                    }
                }
            }
        } catch let error {
            print(
                "Error loading leaderboard entries: \(error.localizedDescription)"
            )
        }

        return readerboardData
    }
}
