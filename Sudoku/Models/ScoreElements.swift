//
//  ScoreElements.swift
//  Sudoku
//
//  Created by Hungu Lim on 9/13/25.
//

import Foundation

/// Codable enumeration for sudoku levels.
///  - Parameters:
///     - none: 0 for no level selected (for testing and init purposes)
///     - easy: 1 for 35 empty cells in sudoku board
///     - medium: 2 for 41 empty cells in sudoku board
///     - hard: 3 for 52 empty cells in sudoku board
enum Level: Int, Codable {
    case none = 0
    case easy
    case medium
    case hard
}

/// Codable struct for various types of scores.
///  - Parameters:
///     - basic: Integer value for score = multiplier x time(seconds)
///     - deduction: Integer value for percentage of basic score depending on number of hints shown.
///     - extra: Integer value for extra points based on completion of row/column/block.
///     - combo: Integer value for number of correct answers solved in a row.
struct Scores: Codable {
    var basic: Int = 0
    var deduction: Int = 0
    var extra: Int = 0
    var combo: Int = 0
}

/// Codable struct containing properties of score.
/// - Parameters:
///     - isRunning: Boolean value indicating whether game is in progress or not.
///     - level: Level value indicating what level user is in.
///     - scores: Scores value containing types of scores.
///     - total: Integer value calculating total score.
///         - basic - deduction + extra + combo
///     - time: Integer value of game time in seconds
///     - errors: Integer value of number of incorrect answers by user.
///     - multiplier: Integer value of basic score element.
///         - case .easy: count down every 30 seconds
///         - case .medium: count down every 60 seconds
///         - case .hard: count down every 90 seconds
///     - completedRCB: Integer value of completed row/column/block
///     - combos: Integer value of combos.
///     - hints: Integer value counting number of hints shown.
/// - Methods:
///     - `getScore()`
///         - Function: retrieves basic scorfe and combos.
struct ScoreElements: Codable {
    var isRunning: Bool
    var level: Level
    var scores: Scores
    var total: Int {
        self.scores.basic - self.scores.deduction + self.scores.extra
            + self.scores.combo
    }
    var time: Int
    var errors: Int
    var multiplier: Int {
        var rtn = 1
        switch self.level {
        case .easy:
            rtn = (self.time / 30) + 1
        case .medium:
            rtn = (self.time / 60) + 1
        case .hard:
            rtn = (self.time / 90) + 1
        default:
            rtn = 1
        }

        if rtn > 10 {
            rtn = 10
        }

        return rtn
    }
    var completedRCB: Int {
        willSet(newValue) {
            self.scores.extra += (newValue * 10)
        }
    }
    var combos: Int
    var hints: Int

    mutating func getScore() {
        self.scores.basic += (self.time * self.multiplier)

        if self.combos >= 10 {
            self.scores.combo += 200
        } else if self.combos >= 5 {
            self.scores.combo += 100
        }
    }
}
