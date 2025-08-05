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
    @Binding var path: [Screen]
    var body: some View {
        VStack {
            Text(String(localized: "Levels"))
                .font(.custom("Chalkduster", size: 28))
                .bold()
            // Spacer()
            Button {
                // Change "score" text in GameBoard View to easy
                // Connect to GameBoardView
                path.append(.boardView)
            } label: {
                NameButtonView(title: String(localized: "Easy"), size: 32)
            }
            .padding()
            
            Button {
                // Change "score" text in GameBoard View to medium
                // Connect to GameBoardView
                path.append(.boardView)
            } label: {
                NameButtonView(title: String(localized: "Medium"), size: 32)
            }
            .padding()
            
            Button {
                // Change "score" text in GameBoard View to hard
                // Connect to GameBoardView
                path.append(.boardView)
            } label: {
                NameButtonView(title: String(localized: "Hard"), size: 32)
            }
            .padding()
            
            // Spacer()
//            Button("Resume") {
//                // Change "score" text in GameBoard View to resumed game
//                // Connect to GameBoardView
//                path.append(.boardView)
//            }
        }
    }
}

#Preview {
    @Previewable @State var path = [Screen]()
    LevelView(path: $path)
}
