//
//  Cell.swift
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

/// All the properties of a cell as well as updating its note.
/// - Parameters:
///     - value: the cell's own value, as an integer
///     - visible: Boolean value for its visibility
///     - position: CellPosition that represents its position on the board
///     - note: A set of integers containing possible candidates for its cell
///     if the visibility is off
///     - select: Boolean value representing if the cell's selected or not
/// - Methods:
///     - `init()` : Sets its value to its own value
///     - `selectCell()`: Automatically sets a cell's visbility to true when there's only one candidate
///     left in the cell's note
///     -`updateNote()`: shows the intersection of the cell's boardNotes if visibility is false for the cell's
///     value, and empties the note if visibility is true.
///     - `==` : compares rows' and columns' SudokuCells to each other
struct Cell: Codable {
    var value: Int = 0
    var visible: Bool = true
    var position: CellPosition = CellPosition()
    var note: Set<Int> = Set<Int>()
    var select: Bool = false

    init(value: Int) {
        self.value = value
    }

    /// Funtion that automatically shows the value when there's only one candidate left in the cell's note.
    mutating func selectCell() {

        if visible {
            visible = false
            note.insert(value)
        } else {
            if note.count == 1 {
                visible = true
                note.removeAll()
            }
        }
    }

    /// Function that updates the cell's note according to the cell's visibility.
    /// - Parameters:
    ///     - boardNotes: A collection of all the invisible cell's value for its row, column, and block.
    ///     - isVisible: Boolean representing if cell's value is visible or not
    /// - Logic:
    ///     - If the cell's visibiility is true, empty all values in the note if it is not empty.
    ///     - If the cell's visibility is false, retrieve the intersection of all the row, column, and blocks'
    ///     sets when none of the sets are empty.
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

    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.position.cell.row == rhs.position.cell.row
            && lhs.position.cell.col == rhs.position.cell.col
    }
}
