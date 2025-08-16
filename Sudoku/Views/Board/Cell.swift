//
//  Cell.swift
//  Sudoku
//
//  Created by Hungu Lim on 1/26/25.
//

import SwiftUI

struct Cell: View {
    let data: CellProperty
    let sudoku: Sudoku

    var body: some View {
        Button {
            if data.visible {
                print("My value: \(data.value) - position: \(data.position)")
            } else {
                print(
                    "My Note: \(data.note), Note: \(sudoku.rowNote) \(sudoku.colNote) \(sudoku.blockNote)"
                )
            }
        } label: {
            if data.visible {
                Text(data.value.formatted(.number))
                    .font(.system(size: 1000, weight: .bold))
                    .lineLimit(1)
            } else {
                CellNoteView(note: data.note)
            }
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
    Cell(data: CellProperty(), sudoku: Sudoku(level: 12))
}
