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
    @EnvironmentObject var sudoku: Sudoku
    var index: Int
    @Binding var isPresented: Bool

    var body: some View {
        if sudoku.selectedCell != nil {
            Button {
                if sudoku.numberPad[index].visible {

                    sudoku.checkNumberPadData(
                        data: sudoku.numberPad[index].value
                    )

                    if sudoku.score.completedRCB == 27 {
                        sudoku.gameCompleted = true
                        sudoku.stopScoreCounter()
                        isPresented.toggle()
                    }
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
    @Previewable @State var isShow: Bool = false
    NumberPadView(index: 0, isPresented: $isShow)
        .environmentObject(Sudoku())
}
