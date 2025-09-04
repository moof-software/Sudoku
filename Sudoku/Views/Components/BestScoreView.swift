//
//  BestScoreView.swift
//  Sudoku
//
//  Created by Hungu Lim on 9/3/25.
//

import SwiftUI

struct BestScoreView: View {
    var level: String
    var bestScore: Int
    var bestRun: Int
    var bestTime: Date

    var body: some View {
        HStack {
            Text(level)
                .frame(width: 150, alignment: .center)
                .font(.custom("Chalkduster", size: 18))
            VStack(alignment: .trailing) {
                Text("best score:")
                Text("best run:")
                Text("best time:")
            }
            VStack(alignment: .leading) {
                if bestScore == 0 {
                    Text("none")
                        .foregroundStyle(Color.red)
                    Text(" ")
                    Text(" ")
                } else {
                    Text("\(bestScore)")
                        .foregroundStyle(Color.blue)
                    Text("\(bestRun)")
                    Text(
                        bestTime,
                        format: .dateTime.hour(.twoDigits(amPM: .omitted))
                            .minute()
                    )
                }
            }
            .fontWeight(.bold)
        }
    }
}

#Preview {
    BestScoreView(level: "Easy", bestScore: 0, bestRun: 0, bestTime: Date.now)
}
