//
//  Sudoku.swift
//  moof_ios_sudoku
//
//  Created by Hungu Lim on 7/23/22.
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
    var filled: Bool = false
    var table: [[SudokuValue]] = Array(
        repeating: Array(
            repeating: SudokuValue(value: 0, visible: true),
            count: 9
        ),
        count: 9
    )

    init() {
        while filled != true {
            seeding()
            filled = setSudokuData()
        }
        print(table)
    }

    func seeding() {
        var seed: Int = 0
        var dice: Set<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9]

        table = Array(
            repeating: Array(
                repeating: SudokuValue(value: 0, visible: true),
                count: 9
            ),
            count: 9
        )

        for index in 0...8 {
            let rowIndexCell = (index / 3)
            let rowIndexData = (index % 3)

            seed = Array(dice).randomElement()!

            table[rowIndexCell][rowIndexData].value = seed
            dice.remove(seed)
        }
    }

    func setSudokuData() -> Bool {
        for row in 1...8 {
            for column in 0...8 {
                if getCellData(cell: SudokuCell(row: row, column: column)).value == 0 {
                    if setCellData(cell: SudokuCell(row: row, column: column)) != 0 {
                        return false
                    }
                }
            }
        }
        return true
    }

    func checkCellRowColumn(cell: SudokuCell) -> (cell: [Int], row: [Int], column: [Int]) {
        var cellData = Array(repeating: 0, count: 9)
        var rowData = Array(repeating: 0, count: 9)
        var columnData = Array(repeating: 0, count: 9)

        for index in 0...8 {
            let indexCell = ((cell.row / 3) * 3) + (cell.column / 3)
            cellData[index] = table[indexCell][index].value
        }

        for index in 0...8 {
            let rowIndexCell = ((cell.row / 3) * 3) + (index / 3)
            let rowIndexData = ((cell.row % 3) * 3) + (index % 3)

            let colIndexCell = ((index / 3) * 3) + (cell.column / 3)
            let colIndexData = ((index % 3) * 3) + (cell.column % 3)

            rowData[index] = table[rowIndexCell][rowIndexData].value
            columnData[index] = table[colIndexCell][colIndexData].value
        }

        return (cellData, rowData, columnData)
    }

    func getCellData(cell: SudokuCell) -> SudokuValue {
        let indexCell = ((cell.row / 3) * 3) + (cell.column / 3)
        let indexData = ((cell.row % 3) * 3) + (cell.column % 3)

        return table[indexCell][indexData]
    }

    func setCellData(cell: SudokuCell) -> Int {
        let sudokuDice: Set<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9]

        let indexCell = ((cell.row / 3) * 3) + (cell.column / 3)
        let indexData = ((cell.row % 3) * 3) + (cell.column % 3)

        let cellData = checkCellRowColumn(cell: cell)
        let subtDice1 = sudokuDice.subtracting(Set(cellData.0))
        let subtDice2 = subtDice1.subtracting(Set(cellData.1))
        let finalDice = subtDice2.subtracting(Set(cellData.2))

        if finalDice.isEmpty {
            return 1
        } else {
            table[indexCell][indexData].value = finalDice.randomElement()!
            return 0
        }
    }

}
