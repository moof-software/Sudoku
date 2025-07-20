//
//  LevelView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// View that allows users to choose which level they are playing on or resume a current game.
///
/// Contains:
/// - VStack
///     - HStack
///         - Back Button
///             - Label: "< Back"
///             - Action: Connect to GameHomeView
///     - "Levels" Text
///     - Easy Button
///         - Label: "Easy"
///         - Action: Change GameBoardView `scoreText` to "Easy", connect to GameBoardView
///     - Medium Button
///         - Label: "Medium"
///         - Action: Change GameBoardView `scoreText` to "Medium", connect to GameBoardView
///     - Hard Button
///         - Label: "Hard"
///         - Action: Change GameBoardView `scoreText` to "Hard", connect to GameBoardView
///     - Resume Button
///         - Label: "Resume"
///         - Action: Change GameBoardView `scoreText` to "Resumed Game", connect to GameBoardView
struct LevelView: View {
    var body: some View {
        VStack {
            HStack {
                Button("< Back") {
                    // Connect to GameHomeView
                }
                .padding()
                Spacer()
            }
            Text("Levels")
                .font(.largeTitle)
                .bold()
            Spacer()
            Button("Easy") {
                // Change "score" text in GameBoard View to easy
                // Connect to GameBoardView
            }
            .buttonStyle(.bordered)
            Button("Medium") {
                // Change "score" text in GameBoard View to medium
                // Connect to GameBoardView
            }
            .buttonStyle(.bordered)
            Button("Hard") {
                // Change "score" text in GameBoard View to hard
                // Connect to GameBoardView
            }
            .buttonStyle(.bordered)
            Spacer()
            Button("Resume") {
                // Change "score" text in GameBoard View to resumed game
                // Connect to GameBoardView
            }
        }
    }
}

#Preview {
    LevelView()
}
