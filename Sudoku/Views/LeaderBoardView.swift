//
//  LeaderBoardView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/15/25.
//

import SwiftUI

/// - Type: Action Sheet
/// - 1개의 Button을 갖는다
///     - Tile: Home
///     - Action: GameHomeView 열기 또는 dismiss()
struct LeaderBoardView: View {

    @State private var displayedText = "Leaderboard Screen"

    var body: some View {
        VStack {
            HStack {
                Button("< Back") {
                    // Connect to GameHomeView
                }
                .padding()
                Spacer()
                Button("Clear") {
                    // Change text from "Leaderboard Screen" to "Cleared"
                    displayedText = "Cleared"
                }
                .padding()
            }
            Spacer()
            Text(displayedText)
            Spacer()
        }
    }
}

#Preview {
    LeaderBoardView()
}
