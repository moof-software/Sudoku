//
//  Sudoku.swift
//  SudokuProApp
//
//  Created by Hungu Lim on 8/08/25.
//

import Foundation
import SwiftData

struct SudokuValue: Codable {
    var value: Int = 0
    var visible: Bool = true
}

struct SudokuCell: Equatable {
    var row: Int = 0
    var column: Int = 0
    var select: Bool = false

    static func == (lhs: SudokuCell, rhs: SudokuCell) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
}

struct SudokuData {
    var data = Array(
        repeating: Array(
            repeating: SudokuValue(value: 0, visible: true),
            count: 9
        ),
        count: 9
    )
}

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
