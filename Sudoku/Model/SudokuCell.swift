//
//  SudokuCell.swift
//  Sudoku
//
//  Created by Hungu Lim on 8/19/25.
//

import Foundation

/// Represents the position of a Sudoku Board
///  - Parameters:
///     - row: a specific cell's position in its row as an integer(0-8)
///     - column: a specific cell's position in its column as an integer(0-8)
struct GridInfo: Codable {
    let row: Int
    let col: Int
}

class SudokuCell: Codable {
    var value: Int = 0
    var visible: Bool {
        willSet(newValue) {
            if !newValue {
                updateNotes()
            }
        }
    }
    var noteInfo: SudokuNote
    var position: CellPosition = CellPosition()

    init(value: Int, noteInfo: SudokuNote) {
        self.value = value
        self.visible = true
        self.noteInfo = noteInfo
    }

    func updateNotes() {
        let row = position.board.row
        let col = position.board.col

        noteInfo.row[row].insert(value)
        noteInfo.col[col].insert(value)
        noteInfo.block[(row / 3) * 3 + (col / 3)].insert(
            value
        )
    }
}
