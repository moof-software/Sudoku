//
//  SudokuCell.swift
//  Sudoku
//
//  Created by Hungu Lim on 8/19/25.
//

import Foundation
import SwiftData

/// Represents the position of a Sudoku Board
///  - Parameters:
///     - row: a specific cell's position in its row as an integer(0-8)
///     - column: a specific cell's position in its column as an integer(0-8)
struct GridInfo: Codable {
    let row: Int
    let col: Int
}

/// All the properties of a cell.
/// - Parameters:
///     - position: CellPosition
///     - visible: Boolean value conforming to showing the content of a cell
///     - value: Integer value contained inside the cell
///     - select: Boolean value conforming to if cell is selected or not
///     - note: Set of integers containing all the numbers in a cell's note
/// - Methods:
///     - `init()` : Sets parameters to
///         - `position` =  A new CellPosition
///         - `visible` = `true`
///         - `value` = 0
///         - `select` = `false`
///         - `note` = Empty `set` of integers
///     - `==` : compares rows' and columns' CellProperties to each other
struct SudokuCell: Codable {
    var value: Int = 0
    var visible: Bool = true
    var position: CellPosition = CellPosition()
    var note: Set<Int> = Set<Int>()
    var select: Bool = false

    init(value: Int) {
        self.value = value
    }

    mutating func selectCell() {
        if note.count == 1 {
            visible = true
            note.removeAll()
        }
    }

    mutating func updateNote(boardNotes: BoardNotes, isVisible: Bool) {
        let row = position.board.row
        let col = position.board.col
        let block = ((row / 3) * 3) + (col / 3)

        if isVisible {
            if !note.isEmpty {
                note.removeAll()
            }
        } else {
            if !boardNotes.col[col].isEmpty {
                if !boardNotes.row[row].isEmpty {
                    note = boardNotes.col[col].intersection(boardNotes.row[row])

                    if !boardNotes.block[block].isEmpty {
                        note = note.intersection(boardNotes.block[block])
                    }
                }
            }
        }
    }

    static func == (lhs: SudokuCell, rhs: SudokuCell) -> Bool {
        return lhs.position.cell.row == rhs.position.cell.row
            && lhs.position.cell.col == rhs.position.cell.col
    }
}
