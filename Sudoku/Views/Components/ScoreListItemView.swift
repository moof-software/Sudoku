//
//  ScoreListItemView.swift
//  Sudoku
//
//  Created by Hungu Lim on 9/16/25.
//

import SwiftUI

struct ScoreListItemView: View {
    let title: String
    let value: Int
    let bold: Bool

    var body: some View {
        HStack {
            Text(title + ":")
                .fontWeight(bold ? .semibold : .regular)
            Spacer()
            Text("\(value)")
        }
    }
}

#Preview {
    ScoreListItemView(title: "Total", value: 100, bold: true)
}
