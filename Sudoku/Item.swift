//
//  Item.swift
//  Sudoku
//
//  Created by Hyunsu Lim on 7/14/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
