//
//  BoardNotes.swift
//  Sudoku
//
//  Created by Hungu Lim on 8/19/25.
//

import Foundation

/// Class that contains potential number candidates
/// for the cell divided by column, row, and block.
///
/// - Parameters:
///     - col: An array of sets of integers conforming to number
///     candidates for a certain cell based on its column
///     - row: An array of sets of integers conforming to number
///     candidates for a certain cell based on its row
///     - block: An array of sets of integers conforming to number
///     candidates for a certain cell based on its block
///
/// - Methods:
///     - `init(col: [Set<Int>], row: [Set<Int>], block: [Set<Int>])`
///         - Parameters: col, row, block of type `[Set<Int>]`
///         - Function: Sets each parameter to its respective array
///     - `updateNotes(position: CellPosition, value:Int)`
///         - Parameters: data of type `SudokuCell`
///         - Function: Checks if cell is visible and update its notes accordingly.
struct BoardNotes: Codable {
    var col: [Set<Int>]
    var row: [Set<Int>]
    var block: [Set<Int>]

    mutating func initAllNotes() {
        for index in 0...8 {
            self.col[index].removeAll()
            self.row[index].removeAll()
            self.block[index].removeAll()
        }
    }

    /// Function for updating notes based on the cell's visibility.
    /// - Parameters:
    ///     - data: selected cell of type `SudokuCell`
    /// - Logic:
    ///     - If `data` is visible, remove its value from all
    ///     of its row, column, and block `BoardNotes`.
    ///     - If `data` is not visible, insert its value to all
    ///     of its row, column, and block `BoardNotes`.
    mutating func updateNotes(data: Cell) {
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

    mutating func getCompletedRCB() -> Int {
        var rtn = 0
        for index in 0...8 {
            if self.col[index].count == 0 {
                rtn += 1
            }

            if self.row[index].count == 0 {
                rtn += 1
            }

            if self.block[index].count == 0 {
                rtn += 1
            }
        }

        return rtn
    }
}
