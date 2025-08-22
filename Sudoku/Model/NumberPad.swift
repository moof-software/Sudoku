//
//  NumberPad.swift
//  Sudoku
//
//  Created by Hungu Lim on 8/22/25.
//

import Foundation

struct NumberPad: Codable {
    var value: Int = 0
    var visible: Bool = true

    init(value: Int) {
        self.value = value
    }
}
