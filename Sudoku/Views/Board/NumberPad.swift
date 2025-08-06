//
//  NumberPad.swift
//  Sudoku
//
//  Created by Jisu Lim on 8/5/25.
//
import SwiftUI

// work in progress, will ask dad.
struct NumberPad: View {
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<9) { index in
                Cell(data: CellData(
                    value: index + 1,
                    board: Grid(row: 0, col: 0), // All in same cell
                    block: Grid(row: 0, col: index)
                ))
            }
        }
        .padding()
    }
}

#Preview {
    NumberPad()
}
