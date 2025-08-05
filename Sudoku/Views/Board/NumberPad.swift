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
                // Row and column within the cell (3x3)
                let row = index / 3
                let col = index % 3

                Tile(info: TileInfo(
                    value: index + 1,
                    cell: MatrixInfo(row: 0, col: 0), // All in same cell
                    colRow: MatrixInfo(row: row, col: col)
                ))
                .frame(width: 50, height: 50)
            }
        }
        .padding()
    }
}

#Preview {
    NumberPad()
}
