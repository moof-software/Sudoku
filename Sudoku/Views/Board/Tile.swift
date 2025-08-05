//
//  Tile.swift
//  Sudoku
//
//  Created by Hungu Lim on 1/26/25.
//

import SwiftUI

struct MatrixInfo {
    let row: Int
    let col: Int
}

struct TileInfo {
    let value: Int?
    let cell: MatrixInfo
    let colRow: MatrixInfo
}

struct Tile: View {
    let info: TileInfo

    var board: MatrixInfo {
        let cell = info.cell
        let tile = info.colRow

        return MatrixInfo(
            row: (cell.row * 3) + tile.row,
            col: (cell.col * 3) + tile.col
        )
    }

    var value: Int {
        /* Dispaly Board info
        //        let board = board
        //        return ((board.col + 1) * 10) + (board.row + 1)
        */
        /// Using temp value
        let tile = info.colRow
        return (tile.row * 3) + tile.col + 1
        ///
    }

    var body: some View {
        Button {
            print("My value: \(value)")
        } label: {
            Text(value.formatted(.number))
                .font(.system(size: 1000, weight: .bold))
                .lineLimit(1)
        }
        #if os(macOS)
            .buttonStyle(.plain)
        #endif
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .minimumScaleFactor(0.01)
        .background(.gray)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    Tile(
        info: TileInfo(
            value: 0,
            cell: MatrixInfo(row: 0, col: 0),
            colRow: MatrixInfo(row: 0, col: 0)
        )
    )
}
