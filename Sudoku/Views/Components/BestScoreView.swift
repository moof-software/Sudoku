//
//  BestScoreView.swift
//  Sudoku
//
//  Created by Hungu Lim on 9/3/25.
//

import SwiftUI

struct BestScoreView: View {
    var level: Level
    var best: RecordedBest

    var body: some View {
        HStack {
            switch level {
            case .easy:
                Text(String(localized: "Easy"))
                    .frame(width: 150, alignment: .center)
                    .font(.custom("Chalkduster", size: 18))
            case .medium:
                Text(String(localized: "Medium"))
                    .frame(width: 150, alignment: .center)
                    .font(.custom("Chalkduster", size: 18))
            case .hard:
                Text(String(localized: "Hard"))
                    .frame(width: 150, alignment: .center)
                    .font(.custom("Chalkduster", size: 18))
            default:
                Text(String(localized: "Easy"))
                    .frame(width: 150, alignment: .center)
                    .font(.custom("Chalkduster", size: 18))
            }

            VStack(alignment: .trailing) {
                Text(String(localized: "best score:"))
                Text(String(localized: "best run:"))
                Text(String(localized: "best time:"))
            }
            VStack(alignment: .leading) {
                if best.score == 0 {
                    Text(String(localized: "none"))
                        .foregroundStyle(Color.red)
                    Text(" ")
                    Text(" ")
                } else {
                    Text("\(best.score)")
                        .foregroundStyle(Color.blue)
                    Text("\(best.run)")
                    Text(
                        String(
                            format: "%02d:%02d",
                            best.time / 60,
                            best.time % 60
                        )
                    )
                }
            }
            .fontWeight(.bold)
        }
    }
}

#Preview {
    BestScoreView(
        level: .easy,
        best: RecordedBest()
    )
}
