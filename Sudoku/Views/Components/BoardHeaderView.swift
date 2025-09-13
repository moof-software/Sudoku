//
//  BoardHeaderView.swift
//  Sudoku
//
//  Created by Hungu Lim on 9/13/25.
//

import SwiftUI

struct BoardHeaderView: View {
    @EnvironmentObject var sudoku: Sudoku
    var statusText: String

    init(statusText: String) {
        self.statusText = statusText
    }

    var body: some View {
        HStack {
            VStack {
                //            - Text: "Errors"
                //                - Font: Custom font "Chalkduster", size: 18
                Text(String(localized: "Errors"))
                    .font(.custom("Chalkduster", size: 18))
                Text("\(sudoku.score.errors)")
                    .font(.custom("Chalkduster", size: 25))
            }
            .padding(.horizontal)

            Spacer()
            VStack {
                HStack {
                    //            - Text: scoreText
                    //                - Font: Custom font "Chalkduster", size: 18
                    Text(String(localized: "Time"))
                        .font(.custom("Chalkduster", size: 18))
                    Text(" x\(sudoku.score.multiplier)")
                        .font(.custom("Chalkduster", size: 18))
                }
                Text(
                    String(
                        format: "%02d:%02d",
                        sudoku.score.time / 60,
                        sudoku.score.time % 60
                    )
                )
                .font(.custom("Chalkduster", size: 25))
            }
            Spacer()

            VStack {
                //            - Text: "Time"
                //                - Font: Custom font "Chalkduster", size: 18
                Text(statusText)
                    .font(.custom("Chalkduster", size: 18))
                Text("\(sudoku.score.total)")
                    .font(.custom("Chalkduster", size: 25))
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    BoardHeaderView(statusText: "Score")
        .environmentObject(Sudoku())
}
