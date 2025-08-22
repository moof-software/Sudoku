//
//  CellView.swift
//  Sudoku
//
//  Created by Hungu Lim on 1/26/25.
//

import SwiftUI

struct CellView: View {
    @Bindable var sudoku: Sudoku
    var row: Int
    var col: Int
    var body: some View {
        Button {
            if sudoku.table[row][col].visible {
                sudoku.table[row][col].selectCell()
                sudoku.notes.updateNotes(data: sudoku.table[row][col])
                sudoku.refreshCellNotes(
                    grid: sudoku.table[row][col].position.board
                )

                print(
                    "My value: \(sudoku.table[row][col].value) - position: \(sudoku.table[row][col].position)"
                )
            } else {

                sudoku.table[row][col].selectCell()
                sudoku.notes.updateNotes(data: sudoku.table[row][col])
                sudoku.refreshCellNotes(
                    grid: sudoku.table[row][col].position.board
                )

                print("My note: \(sudoku.table[row][col].note)")
            }
        } label: {
            if sudoku.table[row][col].visible {
                Text(sudoku.table[row][col].value.formatted(.number))
                    .font(.system(size: 1000, weight: .bold))
                    .lineLimit(1)
            } else {
                CellNoteView(note: sudoku.table[row][col].note)
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
    @Previewable @State var data: Sudoku = Sudoku(level: 0)
    CellView(sudoku: data, row: 0, col: 0)
}
