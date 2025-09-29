//
//  GameCenterManager.swift
//  Sudoku
//
//  Created by Hungu Lim on 9/27/25.
//

import Foundation
import GameKit
import SwiftUI

/// Class for managing Game Center access and leaderboards throughout the game.
///
/// - Parameters:
///     - instance: static constant calling the class itself (singleton pattern).
///     - localPlayer: variable calling for the local player in Game Kit.
///     - init: private variable.
///
/// - Methods:
///     - `getLeaderboardIDs`
///         - Parameter: `level` of type `Level`
///         - Returns: an array of `String`s
///         - Function: retrieves leaderboard IDs
///     - `getLevelLeaderboardTitle`
///         - Parameter: `level` of type `Level`
///         - Returns: an array of strings
///         - Function: retreives the title of leaderboards
///     - `authenticateGameCenter`
///         - Function: authenticates local player
///     - `submitScoreToGameCenter`
///         - Parameter: `score` of type `ScoreElements`
///         - Function: Submits local player's score to Game Center
///     - `submitTimeToGameCenter`
///         - Parameter: `score` of type `ScoreElements`
///         - Function: Submits local player's time to Game Center
///     - `loadGameLeaderboards`
///         - async
///         - Returns: an array of `RecordedBest`s
///         - Function: awaits and inserts scores retrieved from Game Center Leaderboards
///     - `getLeaderboardData`
///         - async
///         - Parameter: `level` of type `Level`
///         - Returns: `RecordedBest`
///         - Function: awaits and brings in data from Game Kit Leadarboard.
class GameCenterManager {
    static let instance = GameCenterManager()

    var localPlayer = GKLocalPlayer.local

    private init() {

    }

    /// Function for retrieves leaderboard IDs.
    /// - Parameters:
    ///     - level: selected level of type `Level`
    /// - Returns:
    ///     - An arry of `String`s.
    /// - Logic:
    ///     - Creates a varaible of an emtpy string titled `levelString`.
    ///     - Set variable according to level and return IDs for score and time leaderboard.
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
            "sudokupro." + levelString + ".leaderboard.time"
        ]
    }

    /// Function for retreives the title of leaderboards.
    /// - Parameters:
    ///     - level: selected level of type `Level`
    /// - Returns:`String`
    /// - Logic:
    ///     - Creates a varaible of an emtpy string titled `titleString`.
    ///     - Set variable according to level and return title.
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

    /// Function for authenticating local player.
    /// - Logic:
    ///     - uses `authenticateHandler` function from GK to authenticate local player.
    func authenticateGameCenter() {
        localPlayer.authenticateHandler = { _, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            print("\(GKLocalPlayer.local.alias) is ready to play!")
        }
    }

    /// Function for submitting local player's score to Game Center
    /// - Parameters:
    ///     - score: local player score of type `ScoreElements`
    /// - Logic:
    ///     - Makes sure local player is authenticated with `guard`.
    ///     - uses `submitScore` from Game Kit to input local score to GK.
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

    /// Function for submitting local player's time to Game Center
    /// - Parameters:
    ///     - score: local player score of type `ScoreElements`
    /// - Logic:
    ///     - Makes sure local player is authenticated with `guard`.
    ///     - uses `submitScore` from Game Kit to input local time to GK.
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

    /// Async function for awaiting and inserting scores retrieved from Game Center Leaderboards
    /// - Returns: an arry of `RecordedBest`s
    /// - Logic:
    ///     - Creates an array of `RecordedBest`
    ///     - Makes sure local player is authenticated with `guard`
    ///     - Use function `getLeaderboardData` to bring in leaderboard data of each levels
    ///     - Inserts each leaderboard data to respective location in array (use Level's raw value)
    func loadGameLeaderboards() async -> [RecordedBest] {
        var bestScore: [RecordedBest] = [
            RecordedBest(score: 0, run: 0, time: 900),
            RecordedBest(score: 0, run: 0, time: 300),
            RecordedBest(score: 0, run: 0, time: 600),
            RecordedBest(score: 0, run: 0, time: 900)
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

    /// Async function for awaiting and bringing in data from Game Kit Leadarboard
    /// - Parameters:
    ///     - level: recorded level of type `Level`
    /// - Returns:`RecordedBest`
    /// - Logic:
    ///     - Creates variable `readerboardData` of type `RecordedBest` and sets it to hard level inputs.
    ///     - Retrieve leaderboard IDs.
    ///     - Await leaderboards with Game Kit's `loadLeaderboards` function.
    ///     - Loads in top ten entries from each leaderboard.
    ///         - If we are at player level, load best scores and times for player only.
    ///         - Else, just let the first place's data be the data brought in.
    func getLeaderboardData(level: Level) async -> RecordedBest {
        //var leaderboards: [GKLeaderboard] = []
        var readerboardData: RecordedBest = RecordedBest(
            score: 0,
            run: 0,
            time: 900
        )
        // Retrieve leaderboard data
        let leaderboardIDs = getLeaderboardIDs(level: level)

        do {
            // Load the specific leaderboard
            let loadedboards = try await GKLeaderboard.loadLeaderboards(
                IDs: leaderboardIDs
            )

            // loadedboards.first != nil .... is this right?
            if let leaderboard = loadedboards.first {
                for leaderboard in loadedboards {
                    let (localPlayerEntry, entries, _) = try await leaderboard.loadEntries(
                            for: .global,
                            timeScope: .allTime,
                            range: NSRange(location: 1, length: 10)  // Ranks 1-10
                        )

                    if let leaderboardTitle = leaderboard.title {
                        if leaderboardTitle
                            == self.getLevelLeaderboardTitle(level: level) {
                            if level == .player {
                                if let localEntry = localPlayerEntry {
                                    readerboardData.score = localEntry.score
                                }
                            } else {
                                if let leader = entries.first {
                                    readerboardData.score = leader.score
                                }
                            }
                        } else {
                            if level == .player {
                                if let localEntry = localPlayerEntry {
                                    readerboardData.time = localEntry.score
                                }
                            } else {
                                if let leader = entries.first {
                                    readerboardData.time = leader.score
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
