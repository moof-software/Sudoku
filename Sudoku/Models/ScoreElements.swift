//
//  ScoreElements.swift
//  Sudoku
//
//  Created by Hungu Lim on 9/13/25.
//

import Foundation

struct ScoreElements: Codable {
    var isRunning: Bool
    var level: Int
    var total: Int
    var time: Int
    var errors: Int
    var multiplier: Int
}
