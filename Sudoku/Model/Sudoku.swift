//
//  Sudoku.swift
//  SudokuProApp
//
//  Created by Hungu Lim on 8/08/25.
//

import Foundation
import SwiftData

/// Represents the value stored in a Sudoku cell, conformes to Codable
/// - Parameters:
///     - value: Int variable set to 0
///     - visible: Bool variable set to `true`
struct SudokuValue: Codable {
    var value: Int = 0
    var visible: Bool = true
}

/// Represents a cell's position and selection state in the Sudoku grid, conforms to Equatable
/// - Parameters:
///     - row: Int variable set to 0
///     - column: Int variable set to 0
///     - select: Bool variable set to `false`
/// - Methods:
///     - `==`: returns Boolean conforming to row and column comparisons.
struct SudokuCell: Equatable {
    var row: Int = 0
    var column: Int = 0
    var select: Bool = false
    
    static func == (lhs: SudokuCell, rhs: SudokuCell) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
}

/// Stores a 9x9 grid of `SudokuValue`s.
/// - Parameters:
///     - data: Array variable containing a 9x9 matrix of SudokuValues equal to 0.
struct SudokuData {
    var data = Array(
        repeating: Array(
            repeating: SudokuValue(value: 0, visible: true),
            count: 9
        ),
        count: 9
    )
}

/// A SwiftData model representing a Sudoku puzzle.
/// - Parameters:
///     - table: Array variable containing a 9x9 matrix of SudokuValues equal to 0.
/// - Methods:
///     - init(): call seeding() and print table
///     - seeding(): function that fills in the table row by row using a randomized dice and sudokuDataSwapper()
///     - sudokuDataSwapper(): function that performs random row and column swaps for a number of totalSwaps
@Model
class Sudoku {
    var table: [[SudokuValue]] = Array(
        repeating: Array(
            repeating: SudokuValue(value: 0, visible: true),
            count: 9
        ),
        count: 9
    )

    init() {
        seeding()
        print(table)
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

        table = Array(
            repeating: Array(
                repeating: SudokuValue(value: 0, visible: true),
                count: 9
            ),
            count: 9
        )

        for row in 0...8 {
            for col in 0...8 {
                let valueIndex = (col + (row % 3) * 3 + (row / 3)) % 9

                seed = dice[valueIndex]

                table[row][col].value = seed
            }
        }
        sudokuDataSwapper()
    }
    /// Function for randomly swapping rows and columns
    /// - Logic:
    ///     - Two variables
    ///         - `totalBlockRows`: Integer variable set to 2
    ///         - `totalSwap`: Integer variable set to 6
    ///     - First, loop over totalBlockRows and totalSwap x2 to swap the number of rows, columns, and blocks
    ///     - Second, swap selected row, column, and block with swapAt.
    func sudokuDataSwapper() {
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
}
