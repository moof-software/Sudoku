//
//  BoardNotes.swift
//  Sudoku
//
//  Created by Hungu Lim on 8/19/25.
//

import Foundation

class BoardNotes: Codable {
    var col: [Set<Int>]
    var row: [Set<Int>]
    var block: [Set<Int>]

    init(col: [Set<Int>], row: [Set<Int>], block: [Set<Int>]) {
        self.col = col
        self.row = row
        self.block = block
    }

    func updateNotes(position: GridInfo, value: Int) {
        row[position.row].insert(value)
        col[position.col].insert(value)
        block[(position.row / 3) * 3 + (position.col / 3)].insert(
            value
        )
    }
}
