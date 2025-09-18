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
            if title == "Time" {
                Text(
                    String(
                        format: "%02d:%02d",
                        value / 60,
                        value % 60
                    )
                )
            } else {
                Text("\(value)")
            }
        }
    }
}

#Preview {
    ScoreListItemView(title: "Total", value: 100, bold: true)
}
