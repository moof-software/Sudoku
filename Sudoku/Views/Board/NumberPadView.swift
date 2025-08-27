import SwiftData
//
//  NumberPadView.swift
//  Sudoku
//
//  Created by Jisu Lim on 8/5/25.
//
import SwiftUI

// work in progress, will ask dad.
struct NumberPadView: View {
    @Bindable var sudoku: Sudoku
    var index: Int

    var body: some View {
        if sudoku.selectedCell != nil {
            Button {
                if sudoku.numberPad[index].visible {

                    sudoku.checkNumberPadData(
                        data: sudoku.numberPad[index].value
                    )
                    print(
                        "NumberPad value: \(sudoku.numberPad[index].value)"
                    )
                }
            } label: {
                if sudoku.numberPad[index].visible {
                    Text(sudoku.numberPad[index].value.formatted(.number))
                        .font(.system(size: 1000, weight: .black))
                        .lineLimit(1)
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
}

#Preview {
    @Previewable @State var data: Sudoku = Sudoku(level: 0)
    NumberPadView(sudoku: data, index: 0)
}
