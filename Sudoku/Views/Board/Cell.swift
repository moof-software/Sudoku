//
//  Cell.swift
//  Sudoku
//
//  Created by Hungu Lim on 1/26/25.
//

import SwiftUI

struct Cell: View {
    let info: MatrixInfo

    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.2))
                .foregroundStyle(Color.gray.opacity(0.2))
                .aspectRatio(1.0, contentMode: .fit)

            VStack {
                ForEach(0..<3) { row in
                    HStack {
                        ForEach(0..<3) { col in
                            let tileInfo = MatrixInfo(row: row, col: col)
                            Tile(
                                info: TileInfo(
                                    value: 0,
                                    cell: info,
                                    colRow: tileInfo
                                )
                            )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Cell(info: MatrixInfo(row: 0, col: 0))
}
