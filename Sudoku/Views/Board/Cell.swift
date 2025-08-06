//
//  Cell.swift
//  Sudoku
//
//  Created by Hungu Lim on 1/26/25.
//

import SwiftUI

struct Grid {
    let row: Int
    let col: Int
}

struct CellData {
    let value: Int
    let board: Grid
    let block: Grid
}

struct Cell: View {
    let data: CellData

    var body: some View {
        Button {
            print("My value: \(data.value)")
        } label: {
            Text(data.value.formatted(.number))
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
    Cell(
        data: CellData(
            value: 0,
            board: Grid(row: 0, col: 0),
            block: Grid(row: 0, col: 0)
        )
    )
}
