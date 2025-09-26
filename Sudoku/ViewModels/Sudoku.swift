//
//  Sudoku.swift
//  SudokuProApp
//
//  Created by Hungu Lim on 8/08/25.
//

import Foundation

/// ObservableObject class for Sudoku data.
/// - Parameters:
///     - Published variables
///         - notes: collection of BoardNotes representing each note within a cell.
///         - table: Table value representing a fully genereated sudoku board
///         - numberPad: an array of NumberPad values.
///         - score: initialized ScoreElements
///         - selectedNumber: Integer value indicating the selected value in board.
///         - selectedCell: GridInfo value indicating the selected value in board.
///         - showHint: Boolean value keeping track of when hint is shown and how many times.
///         - gameCompleted: Boolean value keeping track of if the game is finished.
///     - Variables:
///         - gameTimer: Timer value
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
        // Counts number of times hints has been viewed.
        willSet(newValue) {
            if newValue {
                score.hints += 1
            }
        }
    }
    @Published var gameCompleted: Bool = false {
        // deduct points from basic if hints has been viewed.
        // deduction will take a certain percentage of basic score
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
    @Published var setting: SettingPreference = SettingPreference()
    @Published var gameCenterAccess: Bool = false
    @Published var leaderboard: [RecordedBest] = [
        RecordedBest(score: 0, run: 0, time: 0),
        RecordedBest(score: 0, run: 0, time: 0),
        RecordedBest(score: 0, run: 0, time: 0),
        RecordedBest(score: 0, run: 0, time: 0)
    ]

    var gameTimer: Timer = Timer()

    init() {
        initSudoukuBoard()
    }

    /// Function that initializes the sudoku board. Called in init.
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

    /// Function that generates a complete sudoku board.
    ///  - Parameters:
    ///     - invisibleCounter: Integer value counting every non-filled cell.
    ///  - Logic:
    ///     - Starts with different cases for each level. Sets time and invisibility to
    ///       respective level(enum)
    ///     - Randomly selects cells for its value to be invisible and updates notes accordingly.
    ///     - checks to refresh gameCompleted to false.
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

    /// Function that refreshes each and every cell note based on changes made to board.
    /// - Parameters:
    ///     - row: row info
    ///     - col: column info
    ///     - blockRow: calculation of block's row position using `row`
    ///     - blockCol: calculation of block's column position using `col`
    /// - Logic:
    ///     - checks each cell's notes according to every cells' visibility
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
    /// Function for updating various values tied with input from number pad
    /// - Logic:
    ///     - Pulls in the selected cell's row and column info.
    ///     - If the input from number pad matches the selected cell's value,
    ///       deselect cell, show value, update notes to delete any values associated
    ///       with value, and update score if solved without hints.
    ///     - If incorrect, increment error count and reset combo to 0.
    func checkNumberPadData(data: Int) {
        if let targetCell = selectedCell {
            let row = targetCell.row
            let col = targetCell.col

            if table.cell[row][col].value == data {
                selectedCell = nil
                if setting.autoSelect {
                    selectedNumber = data
                } else {
                    selectedNumber = nil
                }
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
                // if error count goes beyond 3,
                // start taking 10 seconds away per error count.
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

    /// Function for turning off number pad values if solved.
    /// - Logic:
    ///     - checks each index and turn off visibility for number that has been used up.
    func updateSolvedNumber() {
        for index in 0...8 {
            if notes.solved.contains(index + 1) {
                numberPad[index].visible = false
            } else {
                numberPad[index].visible = true
            }
        }
    }

    /// Function for timer
    /// - Logic:
    ///     - invalidate timer if game is paused. if not, create timer.
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

    /// Function for running time
    /// - Logic:
    ///     - Keep timer running until time runs out. Invalid if so.
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
    /// Function for starting score count (turning on game progress)
    /// - Logic:
    ///     - Initialize score, set isRunning to true, and start timer.
    func startScoreCounter() {
        initScore()
        score.isRunning = true
        setScoreCounter(pause: false)
    }

    /// Function for initializing scores
    /// - Logic:
    ///     - Create new instance of `Scores()` and reset errors to 0.
    ///     - reset isRunning to false and invalidate timer.
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

    /// Function for stopping score counting.
    /// - Logic:
    ///     - invalidate timer if score is running, then set it to false.
    func stopScoreCounter() {
        if score.isRunning {
            if gameTimer.isValid {
                gameTimer.invalidate()
            }
            score.isRunning = false
        }
    }
}
