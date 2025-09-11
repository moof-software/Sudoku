//
//  BoardView.swift
//  Sudoku
//
//  Created by Hungu Lim on 1/26/25.
//

import SwiftUI

struct BoardView: View {
    var body: some View {
        VStack(spacing: 3) {
            ForEach(0..<3) { row in
                HStack(spacing: 3) {
                    ForEach(0..<3) { col in
                        let blockGrid = GridInfo(row: row, col: col)
                        BlockView(blockGrid: blockGrid)
                            .padding(1)
                    }
                }
            }
        }
    }
}

#Preview {
    BoardView()
        .environmentObject(Sudoku())
}
