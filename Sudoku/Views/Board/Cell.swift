//
//  Cell.swift
//  Sudoku
//
//  Created by Hungu Lim on 1/26/25.
//

import SwiftUI

struct Cell: View {
    let data: CellProperty

    var body: some View {
        Button {
            print("My value: \(data.value) - position: \(data.position)")
        } label: {
            Text(data.value.formatted(.number))
                .font(.system(size: 1000, weight: .bold))
                .lineLimit(1)

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
    Cell(data: CellProperty())
}
