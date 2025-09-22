//
//  BlockView.swift
//  Sudoku
//
//  Created by Hungu Lim on 1/26/25.
//

import SwiftData
import SwiftUI

/// View that contains 3x3 sudoku block.
///
/// - Parameters;
///     - sudoku: an EnvironmentObject for sudoku data
///     - blockGrid: GridInfo element containing grid information.
/// Contains:
/// - ZStack (alignment: .center)
///     - Rounded rectangle with corner radius of 10
///         - Modifications:
///             - frame with maxWidth and maxHeight to infinity
///             - background with color gray, opacity 0.2
///             - foregroundStyle also with color gray, opacity 0.2
///             - aspect ratio for scale of 1.0, contentMode set to fit.
///     - VStack (spacing 2)
///         - 3 Hstacks each containing 3 CellView.
///              - Must set each row and column to grid's row/col x 3 + row/col

struct BlockView: View {
    @EnvironmentObject var sudoku: Sudoku
    let blockGrid: GridInfo

    var body: some View {
        ZStack(alignment: .center) {

            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.2))
                .foregroundStyle(Color.gray.opacity(0.2))
                .aspectRatio(1.0, contentMode: .fit)

            VStack(spacing: 2) {
                ForEach(0..<3, id: \.self) { row in
                    HStack(spacing: 2) {
                        ForEach(0..<3, id: \.self) { col in
                            let localRow = blockGrid.row * 3 + row
                            let localCol = blockGrid.col * 3 + col
                            CellView(
                                row: localRow,
                                col: localCol
                            )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BlockView(blockGrid: GridInfo(row: 0, col: 0))
        .environmentObject(Sudoku())
}
