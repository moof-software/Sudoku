//
//  LevelView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// - Type: Action Sheet
/// - 4개의 Button을 갖는다
///     - Easy
///     - Medium
///     - Hard
///     - (Resume)
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
            }
            .buttonStyle(.bordered)
            
            Button("Medium") {
                // Change "score" text in GameBoard View to medium
            }
            .buttonStyle(.bordered)
            
            Button("Hard") {
                // Change "score" text in GameBoard View to hard
            }
            .buttonStyle(.bordered)
            Spacer()
            Button("Resume") {
                // Change "score" text in GameBoard View to resume
            }
        }
    }
}

#Preview {
    LevelView()
}
