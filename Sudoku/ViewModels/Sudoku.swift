//
//  Sudoku.swift
//  SudokuProApp
//
//  Created by Hungu Lim on 8/08/25.
//

import Foundation

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
    @Published var table: Table = Table()
    @Published var numberPad: [NumberPad] = Array(
        repeating: NumberPad(value: 0),
        count: 9
    )
    @Published var score: ScoreElements = ScoreElements(
        isRunning: false,
        level: .none,
        scores: Scores(),
        time: 0,
        playtime: 0,
        errors: 0,
        completedRCB: 0,
        combos: 0,
        hints: 0
    )
    @Published var selectedNumber: Int?
    @Published var selectedCell: GridInfo?
    @Published var showHint: Bool = false {
        willSet(newValue) {
            if newValue {
                score.hints += 1
            }
        }
    }
    @Published var gameCompleted: Bool = false {
        willSet(newValue) {
            if newValue {
                score.scores.deduction = Int(
                    Double(score.scores.basic)
                        * Double(
                            Double((score.hints < 5) ? score.hints : 5) * 10.0
                                / 100.0
                        )
                )
            }
        }
    }
    var gameTimer: Timer = Timer()

    init() {
        initSudoukuBoard()
    }

    func initSudoukuBoard() {
        if selectedNumber != nil {
            selectedNumber = nil
        }

        if selectedCell != nil {
            selectedCell = nil
        }

        showHint = false
        gameCompleted = false

        table.seeding()
        table.dataSwapper()
        table.updateCellInfo()

        notes.initAllNotes()
        makeTable(level: .none)
        initScore()
        initNumberPadData()
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
    func makeTable(level: Level) {
        var invisibleCounter: Int = 0
        score.level = level

        switch score.level {
        case .easy:
            invisibleCounter = 35
            score.time = 300
        case .medium:
            invisibleCounter = 41
            score.time = 600
        case .hard:
            invisibleCounter = 52
            score.time = 900
        default:
            invisibleCounter = 0
            score.time = 0
        }

        while invisibleCounter > 0 {
            let row = Int.random(in: 0...8)
            let col = Int.random(in: 0...8)

            if table.cell[row][col].visible {
                table.cell[row][col].visible = false
                invisibleCounter -= 1
                notes.updateNotes(data: table.cell[row][col])
                updateSolvedNumber()
                refreshCellNotes(grid: GridInfo(row: row, col: col))
            }
        }

        if gameCompleted {
            gameCompleted = false
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
            table.cell[index][col].updateNote(
                boardNotes: notes,
                isVisible: table.cell[index][col].visible
            )
            // updating each cell's note in its row
            table.cell[row][index].updateNote(
                boardNotes: notes,
                isVisible: table.cell[row][index].visible
            )
            // updating each cell's note in its block
            table.cell[blockRow + (index / 3)][blockCol + (index % 3)]
                .updateNote(
                    boardNotes: notes,
                    isVisible: table.cell[blockRow + (index / 3)][
                        blockCol + (index % 3)
                    ].visible
                )
        }
    }

    func checkNumberPadData(data: Int) {
        if let targetCell = selectedCell {
            let row = targetCell.row
            let col = targetCell.col

            if table.cell[row][col].value == data {
                selectedCell = nil
                selectedNumber = data
                table.cell[row][col].select = false
                table.cell[row][col].visible = true
                notes.updateNotes(data: table.cell[row][col])
                updateSolvedNumber()
                table.cell[row][col].updateNote(
                    boardNotes: notes,
                    isVisible: table.cell[row][col].visible
                )
                refreshCellNotes(grid: targetCell)

                if !showHint {
                    score.completedRCB = notes.getCompletedRCB()
                    score.combos += 1
                    score.getScore()
                }
            } else {
                score.errors += 1
                score.combos = 0
                if score.errors > 3 {
                    if score.time > 10 {
                        score.time -= 10
                    } else {
                        score.time = 0
                    }
                }
            }
        }
    }

    func updateSolvedNumber() {
        for index in 0...8 {
            if notes.solved.contains(index + 1) {
                numberPad[index].visible = false
            } else {
                numberPad[index].visible = true
            }
        }
    }

    func setScoreCounter(pause: Bool) {
        if pause {
            if gameTimer.isValid {
                gameTimer.invalidate()
            }
        } else {
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
        score.playtime += 1
        if score.time > 0 {
            score.time -= 1
        } else {
            if gameTimer.isValid {
                gameTimer.invalidate()
            }
        }
    }

    func startScoreCounter() {
        initScore()
        score.isRunning = true
        setScoreCounter(pause: false)
    }

    func initScore() {
        score.scores = Scores()
        score.errors = 0
        score.playtime = 0

        if score.isRunning {
            if gameTimer.isValid {
                gameTimer.invalidate()
            }
            score.isRunning = false
        }
    }

    func stopScoreCounter() {
        if score.isRunning {
            if gameTimer.isValid {
                gameTimer.invalidate()
            }
            score.isRunning = false
        }
    }
}
