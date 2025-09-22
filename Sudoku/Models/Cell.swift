//
//  Cell.swift
//  Sudoku
//
//  Created by Hungu Lim on 8/19/25.
//

import Foundation

/// Represents the position of a specific cell in the board, block, or cell
/// - Parameters:
///     - board: a GridInfo of the selected cell's position on the 9×9 board (row, col)
///     - block: a GridInfo of the selected cell's position inside its 3×3 block (blockRow, blockCol)
///     - cell: a GridInfo of the selected cell's position inside its 3×3 block cell (0...2, 0...2)
/// - Methods:
///     - `init()` : set each parameter to its respective `GridInfo`
struct CellPosition: Codable {
    var board: GridInfo
    var block: GridInfo
    var cell: GridInfo

    init() {
        self.board = GridInfo(row: 0, col: 0)
        self.block = GridInfo(row: 0, col: 0)
        self.cell = GridInfo(row: 0, col: 0)
    }
}

/// Represents the position of a Sudoku Board
///  - Parameters:
///     - row: a specific cell's position in its row as an integer(0-8)
///     - column: a specific cell's position in its column as an integer(0-8)
struct GridInfo: Codable {
    let row: Int
    let col: Int

    static func == (lhs: GridInfo, rhs: GridInfo) -> Bool {
        return lhs.row == rhs.row
            && lhs.col == rhs.col
    }
}

/// A matrix of SudokuCell conforming to data on a sudoku board
/// - Parameters:
///     - table: a 9x9 matrix of SudokuCell.
struct Table {
    var cell: [[Cell]] = Array(
        repeating: Array(repeating: Cell(value: 0), count: 9),
        count: 9
    )

    /// Function for generating a randomized 9x9 Sudoku board
    /// - Logic:
    ///     - Two variables
    ///         - `seed`: Integer variable set to 0
    ///         - `dice`: An array of Integers set to numbers 1~9
    ///     - First, shuffle dice.
    ///     - Second, create a 9x9 table with 0s
    ///     - Third, fill out each row with valueIndex as calculated below
    mutating func seeding() {
        var seed: Int = 0
        var dice: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]

        dice.shuffle()

        for row in 0...8 {
            for col in 0...8 {
                let valueIndex = (col + (row % 3) * 3 + (row / 3)) % 9
                seed = dice[valueIndex]
                cell[row][col] = Cell(value: seed)
            }
        }
    }

    /// Function for randomly swapping rows and columns
    /// - Logic:
    ///     - Two variables
    ///         - `totalBlockRows`: Integer variable set to 2
    ///         - `totalSwap`: Integer variable set to 6
    ///     - Loop over `totalBlockRows`:
    ///         - Loop over `totalSwap` times two:
    ///             - Set a random variable `randSeed`as a set of integers and
    ///             randomly choose a row and column inside random seed
    ///             - if the random element is even, swap, else, swap everything within the row.
    mutating func dataSwapper() {
        let totalBlockRows: Int = 2
        let totalSwap: Int = 6

        for block in 0...totalBlockRows {
            for swapCounter in 0..<(totalSwap * 2) {
                var randSeed: Set<Int> = [0, 1, 2]
                let idxi = (block * 3) + randSeed.randomElement()!
                randSeed.remove(idxi)
                let idxj = (block * 3) + randSeed.randomElement()!

                if swapCounter % 2 == 0 {
                    cell.swapAt(idxi, idxj)
                } else {
                    for row in 0...8 {
                        cell[row].swapAt(idxi, idxj)
                    }
                }
            }
        }
    }
    /// Function that computes and assigns board, block, and cell coordinates for every cell.
    ///  - Logic:
    ///     - For every cell, update the GridInfo.
    ///         - For board, just update row and column
    ///         - For block, update row and column by dividing it by 3
    ///         - For call, update row and column with its remainder divided by 3.
    mutating func updateCellInfo() {
        for row in 0...8 {
            for col in 0...8 {
                cell[row][col].position.board = GridInfo(row: row, col: col)
                cell[row][col].position.board = GridInfo(row: row, col: col)

                cell[row][col].position.block = GridInfo(
                    row: row / 3,
                    col: col / 3
                )
                cell[row][col].position.block = GridInfo(
                    row: row / 3,
                    col: col / 3
                )

                cell[row][col].position.cell = GridInfo(
                    row: row % 3,
                    col: col % 3
                )
                cell[row][col].position.cell = GridInfo(
                    row: row % 3,
                    col: col % 3
                )
            }
        }
    }
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

    /// Function adding values to note if value is not visible, else if note only contains one,
    /// set visibility to true and empty notes.
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
