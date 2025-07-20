//
//  GameBoardView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// - Type: Navigation Stack
/// - Open시 항상 LevelView를 표시한다.
/// - (임시)1개의 Label을 갖는다
///     - Title: Level
///     - LevelView에서 선택한 값을 표시한다.
/// - (임시)1개의 Button을 갖는다
///     - Tile: End
///     - Action: ScoreView 열기 또는 dismiss()
struct GameBoardView: View {

    @State var scoreText = "Score"
    @State private var boardText = "Board"
    @State private var memoToggled = false

    var body: some View {
        VStack {
            HStack {
                Text("Errors")
                    .padding()
                Spacer()
                Text(scoreText)
                    .padding()
                Spacer()
                Text("Time")
                    .padding()
            }
            Spacer()
            Text(boardText)
                .frame(maxWidth: .infinity, maxHeight: 500)
                .background(Color.gray.opacity(0.2))
            HStack {
                Button("", systemImage: "arrow.counterclockwise") {
                    // change boardText to "rewind" for 3 seconds
                    // Change to rewind
                    boardText = "Rewinding..."
                    // After 3 seconds, revert back
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        boardText = "Board"
                    }
                }
                .padding(10)
                Button("", systemImage: "arrow.left") {
                    // change boardText to "undo" for 3 seconds
                    // Change to undo
                    boardText = "Undoing..."
                    // After 3 seconds, revert back
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        boardText = "Board"
                    }
                }
                .padding(10)
                Button("", systemImage: "arrow.right") {
                    // change boardText to "redo" for 3 seconds
                    // Change to redo
                    boardText = "Redoing..."
                    // After 3 seconds, revert back
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        boardText = "Board"
                    }
                }
                .padding(10)
                Button("Hint") {
                    // change boardText to "Providing Hint" for 3 seconds
                    // Change to Providing Hint
                    boardText = "Providing Hint..."
                    // After 3 seconds, revert back
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        boardText = "Board"
                    }
                }
                .padding(10)
                Spacer()
                Button("", systemImage: "pencil") {
                    // change numberpadText to "Memo"
                    memoToggled.toggle()
                }
                .padding(10)
            }
            Text(memoToggled ? "Memo" : "Number Pad")
                .frame(maxWidth: .infinity, maxHeight: 70)
                .background(Color.gray.opacity(0.2))
            Spacer()
            Button("End") {
                // Connect to ScoreView
            }
            .buttonStyle(.bordered)
            Spacer()
            Text("Ads")
        }
    }
}

#Preview {
    GameBoardView()
}
