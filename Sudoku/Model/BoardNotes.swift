//
//  SudokuNote.swift
//  Sudoku
//
//  Created by Hungu Lim on 8/19/25.
//

import Foundation

class BoardNotes: Codable {
    var col: [Set<Int>]
    var row: [Set<Int>]
    var block: [Set<Int>]

    init(col: [Set<Int>], row: [Set<Int>], block: [Set<Int>]) {
        self.col = col
        self.row = row
        self.block = block
    }
}
