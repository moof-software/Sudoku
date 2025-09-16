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

struct ScoreElements: Codable {
    var isRunning: Bool
    var level: Level
    var total: Int
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

    mutating func getScore() {
        self.total = self.time * self.multiplier
    }
}
