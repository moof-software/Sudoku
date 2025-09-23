//
//  ScoreElements.swift
//  Sudoku
//
//  Created by Hungu Lim on 9/13/25.
//

import Foundation

enum Level: Int, Codable {
    case none = 0
    case easy
    case medium
    case hard
}

struct Scores: Codable {
    var basic: Int = 0
    var deduction: Int = 0
    var extra: Int = 0
    var combo: Int = 0
}

struct ScoreElements: Codable {
    var isRunning: Bool
    var level: Level
    var scores: Scores
    var total: Int {
        self.scores.basic - self.scores.deduction + self.scores.extra
            + self.scores.combo
    }
    var time: Int
    var playtime: Int
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
