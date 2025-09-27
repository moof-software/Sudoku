//
//  LeaderBoardView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/15/25.
//

import GameKit
import SwiftUI

/// View that shows user's current rankings
///
/// Contains:
/// - VStack
///     - HStack
///         - Back Button
///             - Label: "< Back"
///             - Action: Connect to GameHomeView
///         - Clear Button
///             - Label: "Clear"
///             - Action: Change `displayedText` to "Cleared"
///     - `displayedText` Text
///         - Default must be "Leaderboard Screen"

struct LeaderBoardView: View {
    @EnvironmentObject var sudoku: Sudoku
    @State private var isShowingGameCenter = false
    @State private var gamesPlayed = 122
    @State private var perfectGames = 122

    var body: some View {
        NavigationStack {
            Spacer()

            VStack {
                Button {
                    isShowingGameCenter.toggle()
                } label: {
                    Image("GameCenter")
                        .resizable()
                        .frame(width: 50, height: 50)
                }

                // Leaderboard Screen
                HStack {
                    VStack(alignment: .trailing) {
                        Text(String(localized: "high score:"))
                        Text(String(localized: "games played:"))
                        Text(String(localized: "perfect games:"))
                        Text(String(localized: "playtime:"))
                    }
                    VStack(alignment: .leading) {
                        Text("\(sudoku.bestRecord[Level.player.rawValue].score)")
                            .foregroundStyle(Color.blue)
                        Text("\(gamesPlayed)")
                        Text("\(perfectGames)")
                        Text(
                            String(
                                format: "%02d:%02d",
                                sudoku.bestRecord[Level.player.rawValue].time / 60,
                                sudoku.bestRecord[Level.player.rawValue].time % 60
                            )
                        )
                    }
                    .fontWeight(.bold)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(String(localized: "reset")) {
                        // please put action in
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
            BestScoreView(
                level: .easy,
                best: sudoku.bestRecord[Level.easy.rawValue]
            )
            Spacer()
            BestScoreView(
                level: .medium,
                best: sudoku.bestRecord[Level.medium.rawValue]
            )
            Spacer()
            BestScoreView(
                level: .hard,
                best: sudoku.bestRecord[Level.hard.rawValue]
            )
            Spacer()
            Spacer()
        }
        .onAppear {
            Task {
                sudoku.bestRecord = await GameCenterManager.instance.loadGameLeaderboards()
            }
        }
        .sheet(isPresented: $isShowingGameCenter) {
            GameCenterView(state: .leaderboards)  // Or .leaderboard for
        }
    }
}

#Preview {
    LeaderBoardView()
        .environmentObject(Sudoku())
}
