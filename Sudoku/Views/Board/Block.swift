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
    let blockGrid: GridInfo

    var body: some View {
        ZStack(alignment: .center) {

            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.2))
                .foregroundStyle(Color.gray.opacity(0.2))
                .aspectRatio(1.0, contentMode: .fit)

            if let lastSudoku = sudoku.last {
                VStack {
                    ForEach(0..<3, id: \.self) { row in
                        HStack {
                            ForEach(0..<3, id: \.self) { col in
                                Cell(
                                    sudoku: lastSudoku,
                                    row: blockGrid.row * 3 + row,
                                    col: blockGrid.col * 3 + col
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Block(blockGrid: GridInfo(row: 0, col: 0))
}
