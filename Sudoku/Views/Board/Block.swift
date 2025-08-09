//
//  Cell.swift
//  Sudoku
//
//  Created by Hungu Lim on 1/26/25.
//

import SwiftData
import SwiftUI

struct Block: View {
    @Query var sudoku: [Sudoku]
    let boardGrid: Grid

    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.2))
                .foregroundStyle(Color.gray.opacity(0.2))
                .aspectRatio(1.0, contentMode: .fit)

            VStack {
                if !sudoku.isEmpty {
                    let sudokuData = sudoku.last

                    ForEach(0..<3) { row in
                        if let sudokuValue = sudokuData?.table[
                            boardGrid.row * 3 + row
                        ] {
                            HStack {
                                ForEach(0..<3) { col in
                                    let blockGrid = Grid(row: row, col: col)

                                    Cell(
                                        data: CellData(
                                            value: sudokuValue[
                                                boardGrid.col * 3 + col
                                            ]
                                            .value,
                                            board: boardGrid,
                                            block: blockGrid
                                        )
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Block(boardGrid: Grid(row: 0, col: 0))
}
