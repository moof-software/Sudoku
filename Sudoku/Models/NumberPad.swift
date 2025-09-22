//
//  NumberPad.swift
//  Sudoku
//
//  Created by Hungu Lim on 8/22/25.
//

import Foundation

/// Struct for number pad that allows users to input values on the game board
///  - Parameters:
///     - value: Integer value for each number on number pad
///     - visible: Boolean value for visibility on each number pad value
///  - Functions:
///     - `init`: sets value to self.
struct NumberPad: Codable {
    var value: Int = 0
    var visible: Bool = true

    init(value: Int) {
        self.value = value
    }
}
