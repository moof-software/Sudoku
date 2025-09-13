//
//  Sudoku.swift
//  SudokuProApp
//
//  Created by Hungu Lim on 8/08/25.
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

/// A matrix of SudokuCell conforming to data on a sudoku board
/// - Parameters:
///     - table: a 9x9 matrix of SudokuCell.
struct Data {
    var table: [[Cell]]
}

/// A SwiftData model representing a Sudoku puzzle.
/// - Parameters:
///     - notes(@Transient): `BoardNotes` type initialized to 9 empty sets.
///     - table: a 9x9 matrix of `SudokuCell`s creating the table
///     - numberPad: an array of `SudokuCell`s creating the number pad.
///
/// - Methods:
///     - `init()`: calls seeding(), dataSwapper(), updateCellGridInfo(), makeTable(),
///        print table, and initNumberPad().
///     -  `seeding()` — builds a fully solved 9×9 grid by shuffling digits and laying them out with a
///        base pattern.
///     - `dataSwapper()` — randomizes the solved grid by swapping rows within bands and columns
///        within stacks while preserving validity.
///     - `updateCellGridInfo()` — writes board/block/cell coordinates into each `GridInfo`.
///     - `makeTable(level:Int)` — hides a fixed number of cells based on level  to produce a playable
///        puzzle and derives initial notes.
///     - `initNumberPadData()` — populates the keypad model with values 1…9.
///     - `refreshCellNotes(grid:GridInfo)` — reevalutates note values after actions.
class Sudoku: ObservableObject {
    @Published var notes: BoardNotes = BoardNotes(
        col: Array(repeating: Set<Int>(), count: 9),
        row: Array(repeating: Set<Int>(), count: 9),
        block: Array(repeating: Set<Int>(), count: 9)
    )

    @Published var table: [[Cell]] = Array(
        repeating: Array(repeating: Cell(value: 0), count: 9),
        count: 9
    )

    @Published var numberPad: [NumberPad] = Array(
        repeating: NumberPad(value: 0),
        count: 9
    )
    @Published var selectedNumber: Int?
    @Published var selectedCell: GridInfo?
    @Published var showHint: Bool = false

    @Published var score: ScoreElements = ScoreElements(
        isRunning: false,
        level: 1,
        total: 0,
        time: 0,
        errors: 0,
        multiplier: 10
    )

    var gameTimer: Timer = Timer()

    //    var colNote: [Set<Int>] = Array(repeating: Set<Int>(), count: 9)
    //    var rowNote: [Set<Int>] = Array(repeating: Set<Int>(), count: 9)
    //    var blockNote: [Set<Int>] = Array(repeating: Set<Int>(), count: 9)

    init() {
        initSudoukuBoard()
    }

    func initSudoukuBoard() {
        seeding()
        dataSwapper()
        updateCellGridInfo()
        notes.initAllNotes()
        makeTable(level: 0)
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
    func seeding() {
        var seed: Int = 0
        var dice: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]

        dice.shuffle()

        for row in 0...8 {
            for col in 0...8 {
                let valueIndex = (col + (row % 3) * 3 + (row / 3)) % 9

                seed = dice[valueIndex]

                table[row][col] = Cell(value: seed)

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

    /// Function that computes and assigns board, block, and cell coordinates for every cell.
    ///  - Logic:
    ///     - For every cell, update the GridInfo.
    ///         - For board, just update row and column
    ///         - For block, update row and column by dividing it by 3
    ///         - For call, update row and column with its remainder divided by 3.
    private func updateCellGridInfo() {
        for row in 0...8 {
            for col in 0...8 {
                table[row][col].position.board = GridInfo(row: row, col: col)
                table[row][col].position.board = GridInfo(
                    row: row,
                    col: col
                )

                table[row][col].position.block = GridInfo(
                    row: row / 3,
                    col: col / 3
                )
                table[row][col].position.block = GridInfo(
                    row: row / 3,
                    col: col / 3
                )

                table[row][col].position.cell = GridInfo(
                    row: row % 3,
                    col: col % 3
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
            numberPad[index] = NumberPad(value: index + 1)
        }
    }

    /// Functiont that turns visibility off for random cells and updates and refreshes notes
    /// according to that visibility.
    ///  - Parameters:
    ///     - level: an integer corresponding to the number of blank cells
    ///     according to each level.
    ///  - Logic:
    ///     - Randomly decides on a row and column and turns off visibility for
    ///     that cell. Updates and refreshes notes according to this.
    func makeTable(level: Int) {
        var noteCounter = level

        while noteCounter > 0 {
            let row = Int.random(in: 0...8)
            let col = Int.random(in: 0...8)

            if table[row][col].visible {
                table[row][col].visible = false
                noteCounter -= 1

                notes.updateNotes(data: table[row][col])

                refreshCellNotes(grid: GridInfo(row: row, col: col))
            }
        }
    }

    /// Function that refreshes each and every cell note according to updates on BoardNotes
    /// and SudokuCell's notes update.
    /// - Parameters:
    ///     - grid: A GridInfo that provides the function with the cell's row and column info
    /// - Logic:
    ///     - Calculate block's location, then use `SudokuCell`'s `updateNote()` function
    ///     to refresh and reprint each cell note.
    func refreshCellNotes(grid: GridInfo) {
        let row = grid.row
        let col = grid.col

        let blockRow = ((row / 3) * 3)
        let blockCol = ((col / 3) * 3)

        for index in 0...8 {
            // updating each cell's note in its column
            table[index][col].updateNote(
                boardNotes: notes,
                isVisible: table[index][col].visible
            )
            // updating each cell's note in its row
            table[row][index].updateNote(
                boardNotes: notes,
                isVisible: table[row][index].visible
            )
            // updating each cell's note in its block
            table[blockRow + (index / 3)][blockCol + (index % 3)]
                .updateNote(
                    boardNotes: notes,
                    isVisible: table[blockRow + (index / 3)][
                        blockCol + (index % 3)
                    ].visible
                )

        }
    }

    func checkNumberPadData(data: Int) {
        if let targetCell = selectedCell {
            let row = targetCell.row
            let col = targetCell.col

            if table[row][col].value == data {
                selectedCell = nil
                selectedNumber = data
                table[row][col].select = false
                table[row][col].visible = true
                notes.updateNotes(data: table[row][col])
                table[row][col].updateNote(
                    boardNotes: notes,
                    isVisible: table[row][col].visible
                )
                refreshCellNotes(grid: targetCell)
            }
        }
    }

    func setScoreCounter(pause: Bool) {
        if pause {
            print("Game Paused!!!")
            if gameTimer.isValid {
                gameTimer.invalidate()
            }
        } else {
            print("Game Resumed!!!")
            gameTimer = Timer.scheduledTimer(
                withTimeInterval: 1.0,
                repeats: true,
                block: { _ in
                    self.timerAction()
                }
            )
        }
    }

    func timerAction() {
        score.time += 1
    }

    func startScoreCounter() {
        score.total = 0
        score.errors = 0
        score.time = 0
        score.multiplier = 10
        score.isRunning = true

        setScoreCounter(pause: false)
    }

    func stopScoreCounter() {
        if score.isRunning {
            print("Solved All Sudoku !!!")
            if gameTimer.isValid {
                gameTimer.invalidate()
            }
            score.isRunning = false
        }
    }
}
