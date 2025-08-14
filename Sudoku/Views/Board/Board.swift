//
//  Board.swift
//  Sudoku
//
//  Created by Hungu Lim on 1/26/25.
//

import SwiftUI

struct Board: View {
    var body: some View {
        VStack {
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { col in
                        let blockGrid = GridInfo(row: row, col: col)
                        Block(blockGrid: blockGrid)
                            .padding(1)
                    }
                }
            }
        }
    }
}

#Preview {
    Board()
}
