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
            if let selectedCell = sudoku.selectedCell {
                sudoku.table[selectedCell.row][selectedCell.col].select = false
                sudoku.selectedCell = nil
            }

            if sudoku.table[row][col].visible {
                sudoku.selectedNumber = sudoku.table[row][col].value
            } else {
                sudoku.selectedNumber = nil
                sudoku.table[row][col].select = true
                sudoku.selectedCell = GridInfo(row: row, col: col)
            }
        } label: {
            if sudoku.table[row][col].visible {
                Text(sudoku.table[row][col].value.formatted(.number))
                    .font(.system(size: 1000, weight: .bold))
                    .lineLimit(1)
                    .foregroundStyle(
                        sudoku.selectedNumber == sudoku.table[row][col].value
                            ? Color.green : Color.white
                    )
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .foregroundStyle(Color.gray.opacity(0.2))
                        .aspectRatio(1.0, contentMode: .fit)

                    if sudoku.showHint {
                        CellNoteView(note: sudoku.table[row][col].note)
                    }
                }
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
        .overlay {
            if sudoku.table[row][col].select {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.red, lineWidth: 5)
                    .opacity(0.5)
            }
        }
    }
}

#Preview {
    @Previewable @State var data: Sudoku = Sudoku(level: 0)
    CellView(sudoku: data, row: 0, col: 0)
}
