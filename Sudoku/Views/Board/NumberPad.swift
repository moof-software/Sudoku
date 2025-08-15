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
        if !sudoku.isEmpty {
            let sudokuData = sudoku.last

            HStack(spacing: 8) {
                ForEach(0..<9) { index in
                    if let padData = sudokuData?.numberPad[index] {
                        Cell(data: padData, sudoku: sudokuData ?? Sudoku())
                    }
                }
            }
            .padding()
        }

    }
}

#Preview {
    NumberPad()
}
