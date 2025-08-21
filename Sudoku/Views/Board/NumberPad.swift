import SwiftData
//
//  NumberPad.swift
//  Sudoku
//
//  Created by Jisu Lim on 8/5/25.
//
import SwiftUI

// work in progress, will ask dad.
struct NumberPad: View {
    @Query var sudoku: [Sudoku]

    var body: some View {
        if let sudokuData = sudoku.last {
            @Bindable var sudokuData = sudokuData

            HStack(spacing: 8) {
                // ForEach(0..<9, id: \.self) { index in
                    //                    Cell(
                    //                        data: $sudokuData.numberPad[index],
                    //                        sudoku: sudokuData
                    //                    )
                // }
            }
            .padding()
        }
    }
}

#Preview {
    NumberPad()
}
