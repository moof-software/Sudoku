//
//  BoardNotes.swift
//  Sudoku
//
//  Created by Hungu Lim on 8/19/25.
//

import Foundation

struct BoardNotes: Codable {
    var col: [Set<Int>]
    var row: [Set<Int>]
    var block: [Set<Int>]

    mutating func updateNotes(data: SudokuCell) {
        let position = data.position.board

        if data.visible {
            row[position.row].remove(data.value)
            col[position.col].remove(data.value)
            block[(position.row / 3) * 3 + (position.col / 3)].remove(
                data.value
            )
        } else {
            row[position.row].insert(data.value)
            col[position.col].insert(data.value)
            block[(position.row / 3) * 3 + (position.col / 3)].insert(
                data.value
            )
        }
    }
}
