//
//  ScoreView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import GameKit
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
    @Binding var path: [Screen]
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var sudoku: Sudoku
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        ScoreListItemView(
                            title: "Basic Score",
                            value: sudoku.score.scores.basic,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Deductions",
                            value: sudoku.score.scores.deduction,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Extra Score",
                            value: sudoku.score.scores.extra,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Combo Score",
                            value: sudoku.score.scores.combo,
                            bold: false
                        )

                        ScoreListItemView(
                            title: "Total",
                            value: sudoku.score.total,
                            bold: true
                        )
                    }
                    Section {
                        ScoreListItemView(
                            title: "Level",
                            value: sudoku.score.level.rawValue,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Time",
                            value: sudoku.score.time,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Errors",
                            value: sudoku.score.errors,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Multiplier",
                            value: sudoku.score.multiplier,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Completed R.C.B.",
                            value: sudoku.score.completedRCB,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Combos",
                            value: sudoku.score.combos,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Hints",
                            value: sudoku.score.hints,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Undo",
                            value: 0,
                            bold: false
                        )
                    }
                }

                Spacer()
                Button("Home") {
                    // Connect to GameHomeView
                    dismiss()
                    path.removeLast()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Final Score")
        }
        .onAppear {
            if sudoku.score.total != 0 {
                submitScoreToGameCenter(score: sudoku.score)
            }
            if sudoku.score.playtime != 0 {
                submitTimeToGameCenter(score: sudoku.score)
            }
        }
    }

    func submitScoreToGameCenter(score: ScoreElements) {
        let localPlayer = GKLocalPlayer.local
        var levelString: String = ""
        switch score.level {
        case .medium:
            levelString = "mediumlevel"
        case .hard:
            levelString = "hardlevel"
        default:
            levelString = "easylevel"
        }
        let leaderboardID = "sudokupro." + levelString + ".leaderboard.score"

        guard GKLocalPlayer.local.isAuthenticated else {
            print("Local player not authenticated. Cannot submit score.")
            return
        }
        // Submit score
        GKLeaderboard.submitScore(
            score.total,
            context: 0,
            player: localPlayer,
            leaderboardIDs: [leaderboardID]
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
        var levelString: String = ""
        switch score.level {
        case .medium:
            levelString = "mediumlevel"
        case .hard:
            levelString = "hardlevel"
        default:
            levelString = "easylevel"
        }
        let leaderboardID = "sudokupro." + levelString + ".leaderboard.time"
        guard GKLocalPlayer.local.isAuthenticated else {
            print("Local player not authenticated. Cannot submit time.")
            return
        }
        // Submit time
        GKLeaderboard.submitScore(
            score.playtime,
            context: 0,
            player: localPlayer,
            leaderboardIDs: [leaderboardID]
        ) { error in
            if let error = error {
                print("Error submitting time: \(error.localizedDescription)")
            } else {
                print("Time submitted successfully!")
            }
        }
    }
}

#Preview {
    @Previewable @State var path = [Screen]()
    ScoreView(path: $path)
        .environmentObject(Sudoku())
}
