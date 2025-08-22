//
//  LevelView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftData
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
    @Environment(\.modelContext) var modelContext
    @Query var sudokus: [Sudoku]
    @Binding var path: [Screen]

    @State var showResumeAlert: Bool = false
    var body: some View {
        VStack {
            Text(String(localized: "Levels"))
                .font(.custom("Chalkduster", size: 28))
                .bold()
            // Spacer()
            Button {
                // Change "score" text in GameBoard View to easy
                // Connect to GameBoardView
                if sudokus.isEmpty {
                    modelContext.insert(Sudoku(level: 35))
                    path.append(.boardView)
                } else {
                    showResumeAlert.toggle()
                }
            } label: {
                NameButtonView(title: String(localized: "Easy"), size: 32)
            }
            .padding()

            Button {
                // Change "score" text in GameBoard View to medium
                // Connect to GameBoardView
                if sudokus.isEmpty {
                    modelContext.insert(Sudoku(level: 42))
                    path.append(.boardView)
                } else {
                    showResumeAlert.toggle()
                }
            } label: {
                NameButtonView(title: String(localized: "Medium"), size: 32)
            }
            .padding()

            Button {
                // Change "score" text in GameBoard View to hard
                // Connect to GameBoardView
                if sudokus.isEmpty {
                    modelContext.insert(Sudoku(level: 51))
                    path.append(.boardView)
                } else {
                    showResumeAlert.toggle()
                }
            } label: {
                NameButtonView(title: String(localized: "Hard"), size: 32)
            }
            .padding()

            //  Button("Resume") {
            //                // Change "score" text in GameBoard View to resumed game
            //                // Connect to GameBoardView
            //                path.append(.boardView)
            //            }
            if !sudokus.isEmpty {
                Button {
                    path.append(.boardView)
                } label: {
                    NameButtonView(title: String(localized: "Resume"), size: 32)
                }
                .padding()
            }

        }
        .alert(
            "Previous game exists, remove and create new?",
            isPresented: $showResumeAlert
        ) {
            Button("Create", role: .destructive) {
                modelContext.delete(sudokus[0])
                modelContext.insert(Sudoku(level: 35))
                path.append(.boardView)
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

#Preview {
    @Previewable @State var path = [Screen]()
    LevelView(path: $path)
}
