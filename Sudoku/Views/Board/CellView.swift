//
//  CellView.swift
//  Sudoku
//
//  Created by Hungu Lim on 1/26/25.
//

import SwiftUI

struct CellView: View {
    @EnvironmentObject var sudoku: Sudoku
    var row: Int
    var col: Int
    var body: some View {
        Button {
            if let selectedCell = sudoku.selectedCell {
                sudoku.table.cell[selectedCell.row][selectedCell.col].select =
                    false
                sudoku.selectedCell = nil
            }

            if sudoku.table.cell[row][col].visible {
                sudoku.selectedNumber = sudoku.table.cell[row][col].value
            } else {
                sudoku.selectedNumber = nil
                sudoku.table.cell[row][col].select = true
                sudoku.selectedCell = GridInfo(row: row, col: col)
            }

            if !sudoku.score.isRunning {
                sudoku.startScoreCounter()
            }

        } label: {
            if sudoku.table.cell[row][col].visible {
                Text(sudoku.table.cell[row][col].value.formatted(.number))
                    .font(.system(size: 1000, weight: .black))
                    .lineLimit(1)
                    .foregroundStyle(
                        sudoku.selectedNumber
                            == sudoku.table.cell[row][col].value
                            ? Color.blue : Color.white
                    )
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .foregroundStyle(Color.gray.opacity(0.2))
                        .aspectRatio(1.0, contentMode: .fit)

                    if sudoku.showHint {
                        CellNoteView(note: sudoku.table.cell[row][col].note)
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
            if sudoku.table.cell[row][col].select {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.blue, lineWidth: 5)
                    .opacity(0.5)
            } else {
                if let selectedCell = sudoku.selectedCell {
                    if (sudoku.table.cell[row][col].position.board.row
                        == selectedCell.row)
                        || (sudoku.table.cell[row][col].position.board.col
                            == selectedCell.col) {
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(Color.blue.opacity(0.1))
                            .allowsHitTesting(false)
                    }
                }
            }
        }
    }
}

#Preview {
    CellView(row: 0, col: 0)
        .environmentObject(Sudoku())
}
