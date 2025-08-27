//
//  CellNoteView.swift
//  Sudoku
//
//  Created by Hungu Lim on 8/16/25.
//

import SwiftUI

struct CellNoteView: View {
    let note: Set<Int>

    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.2))
                .foregroundStyle(Color.gray.opacity(0.2))
                .aspectRatio(1.0, contentMode: .fit)

            VStack {
                ForEach(0..<3, id: \.self) { row in
                    HStack(alignment: .center) {
                        ForEach(0..<3, id: \.self) { col in
                            let data: Int = row * 3 + col + 1

                            Text(note.contains(data) ? "\(data)" : " ")
                                .fontWeight(.bold)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CellNoteView(note: [1, 2, 3, 4, 5, 6, 7, 8, 9])
}
