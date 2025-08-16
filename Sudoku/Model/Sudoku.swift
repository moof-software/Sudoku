//
//  Sudoku.swift
//  SudokuProApp
//
//  Created by Hungu Lim on 8/08/25.
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

/// Represents the position of a specific cell in the board, block, or cell
/// - Parameters:
///     - board: a GridInfo of the selected cell's position on the 9×9 board (row, col)
///     - block: a GridInfo of the selected cell's position inside its 3×3 block (blockRow, blockCol)
///     - cell: a GridInfo of the selected cell's position inside its 3×3 block cell (0...2, 0...2)
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
struct CellProperty: Codable, Equatable {
    var position: CellPosition
    var visible: Bool
    var value: Int
    var select: Bool
    var note: Set<Int>

    init() {
        self.position = CellPosition()
        self.visible = true
        self.value = 0
        self.select = false
        self.note = Set<Int>()
    }

    static func == (lhs: CellProperty, rhs: CellProperty) -> Bool {
        return lhs.position.cell.row == rhs.position.cell.row
            && lhs.position.cell.col == rhs.position.cell.col
    }
}

/// A matrix of CellProperties conforming to data on a sudoku board
/// - Parameters:
///     - table: a 9x9 matrix of CellProperties.
struct Data {
    var table: [[CellProperty]]
}

/// A SwiftData model representing a Sudoku puzzle.
/// - Parameters:
///     - table: Array variable containing a 9x9 matrix of CellProperty equal to 0.
///     - numberPad: Array of CellProperty length 9
///     - level: initial integer set to 0, will change as levels change
///     - colNote: An array containing sets of integers with length 9
///     - rowNote: An array containing sets of integers with length 9
///     - blockNote: An array containing sets of integers with length 9
///
/// - Methods:
///     - `init()`: calls seeding(), dataSwapper(), updateCellGridInfo(), makeTable(), and print table
///     -  `seeding()` — builds a fully solved 9×9 grid by shuffling digits and laying them out with a base pattern.
///     - `dataSwapper()` — randomizes the solved grid by swapping rows within bands and columns within stacks while preserving validity.
///     - `updateCellGridInfo()` — writes board/block/cell coordinates into each `CellProperty.position`.
///     - `makeTable(level:)` — hides a fixed number of cells (currently 30) to produce a playable puzzle and derives initial notes.
///     -  `print(table)` — dumps the backing 2D array for debugging.
///     - `initNumberPadData()` — populates the keypad model with values 1…9.
@Model
class Sudoku {
    var table: [[CellProperty]] = Array(
        repeating: Array(repeating: CellProperty(), count: 9),
        count: 9
    )

    var numberPad: [CellProperty] = Array(repeating: CellProperty(), count: 9)

    var colNote: [Set<Int>] = Array(repeating: Set<Int>(), count: 9)
    var rowNote: [Set<Int>] = Array(repeating: Set<Int>(), count: 9)
    var blockNote: [Set<Int>] = Array(repeating: Set<Int>(), count: 9)

    init(level: Int) {
        seeding()
        dataSwapper()
        updateCellGridInfo()
        makeTable(level: level)
        print(table)

        initNumberPadData()
    }

    /// Function for generating a randomized 9x9 Sudoku board
    /// - Logic:
    ///     - Two variables
    ///         - `seed`: Integer variable set to 0
    ///         - `dice`: An array of Integers set to numbers 1~9
    ///     - First, shuffle dice.
    ///     - Second, create a 9x9 table with 0s
    ///     - Third, fill out each row with valueIndex as calculated below
    ///     - Fourth, randomize rows and columns with sudokuDataSwapper
    func seeding() {
        var seed: Int = 0
        var dice: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]

        dice.shuffle()

        for row in 0...8 {
            for col in 0...8 {
                let valueIndex = (col + (row % 3) * 3 + (row / 3)) % 9

                seed = dice[valueIndex]

                table[row][col].value = seed

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
    func dataSwapper() {
        let totalBlockRows: Int = 2
        let totalSwap: Int = 6

        for block in 0...totalBlockRows {
            for swapCounter in 0..<(totalSwap * 2) {
                var randSeed: Set<Int> = [0, 1, 2]

                let idxi = (block * 3) + randSeed.randomElement()!
                randSeed.remove(idxi)
                let idxj = (block * 3) + randSeed.randomElement()!

                if swapCounter % 2 == 0 {
                    self.table.swapAt(idxi, idxj)
                } else {
                    for row in 0...8 {
                        self.table[row].swapAt(idxi, idxj)
                    }
                }
            }
        }

    }

    /// Function that computes and assigns board, block, and in-block cell coordinates for every cell.
    ///  - Logic:
    ///     - For every cell, update the GridInfo.
    ///         - For board, just update row and column
    ///         - For block, update row and column by dividing it by 3
    ///         - For call, update row and column with its remainder divided by 3.
    private func updateCellGridInfo() {
        for row in 0...8 {
            for col in 0...8 {
                table[row][col].position.board = GridInfo(row: row, col: col)
                table[row][col].position.block = GridInfo(
                    row: row / 3,
                    col: col / 3
                )
                table[row][col].position.cell = GridInfo(
                    row: row % 3,
                    col: col % 3
                )
            }
        }
    }

    /// Function that creates the number pad
    /// - Logic:
    ///     - Set board and block's row and column to 0, only set cell to row 0 and column 0-8
    ///     - Set the value of the number pad to 1-9
    private func initNumberPadData() {
        for index in 0...8 {
            numberPad[index].position.board = GridInfo(row: 0, col: 0)
            numberPad[index].position.block = GridInfo(row: 0, col: 0)
            numberPad[index].position.cell = GridInfo(row: 0, col: index)

            numberPad[index].value = index + 1
        }
    }

    /// Function that removes a certain nuber of entries
    ///
    func makeTable(level: Int) {
        var noteCounter = level

        while noteCounter > 0 {
            let row = Int.random(in: 0...8)
            let col = Int.random(in: 0...8)

            if table[row][col].visible {
                table[row][col].visible = false
                noteCounter -= 1

                rowNote[row].insert(table[row][col].value)
                colNote[col].insert(table[row][col].value)
                blockNote[(row / 3) * 3 + (col / 3)].insert(
                    table[row][col].value
                )

                for index in 0...8 {
                    if !table[index][col].visible {
                        if !colNote[col].isEmpty {
                            if !rowNote[index].isEmpty {
                                table[index][col].note = colNote[col]
                                    .intersection(rowNote[index])

                                if !blockNote[((index / 3) * 3) + (col / 3)]
                                    .isEmpty
                                {
                                    table[index][col].note = table[index][col]
                                        .note.intersection(
                                            blockNote[
                                                ((index / 3) * 3) + (col / 3)
                                            ]
                                        )
                                }
                            }
                        }
                    }

                    if !table[row][index].visible {
                        if !rowNote[row].isEmpty {
                            if !colNote[index].isEmpty {
                                table[row][index].note = rowNote[row]
                                    .intersection(colNote[index])

                                if !blockNote[((row / 3) * 3) + (index / 3)]
                                    .isEmpty
                                {
                                    table[row][index].note = table[row][index]
                                        .note.intersection(
                                            blockNote[
                                                ((row / 3) * 3) + (index / 3)
                                            ]
                                        )
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    func updateNotes(cell: CellPosition) {
        // please update
    }
}
