//
//  GameBoardView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// View that contains the main gaming screen.
///
/// Contains:
/// - VStack
///     - HStack
///         - "Error" Text
///             - Placeholder for Errors
///         - `scoreText` Text
///             - Default `scoreText` must be set to "Score"
///             - Placeholder for Scores
///         - "Time" Text
///             - Placeholder for Timer
///     - `boardText` Text
///         - Default `boardText` must be set to "Board"
///         - Placeholder for Sudoku Board
///     - HStack
///         - Rewind Button
///             - Label: arrow.counterclockwise system image
///             - Action: change boardText to "Rewinding..." for 3 seconds
///         - Undo Button
///             - Label: arrow.left system image
///             - Action: change boardText to "Undoing..." for 3 seconds
///         - Redo Button
///             - Label: arrow.right system image
///             - Action: change boardText to "Redoing..." for 3 seconds
///         - Hint Button
///             - Label: "Hint"
///             - Action: change boardText to "Providing hint..." for 3 seconds
///         - Memo Button
///             - Label: pencil system image
///             - Action: Toggle  "Number Pad" text to "Memo" using memoToggled
///     - Number Pad
///         - Currently Text with memoToggled that switches from "Number Pad" to "Memo" when toggled by Memo Button
///     - End Button
///         - Label: "End"
///         - Action: Connects to ScoreView
///     - "Ads" Text
///         - Placeholder
struct GameBoardView: View {

    @Binding var path: [Screen]

    @State var scoreText = "Score"
    @State private var showScoreView: Bool = false
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

            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .foregroundStyle(Color.gray.opacity(0.2))
                    .aspectRatio(1.0, contentMode: .fit)

                Board()
                    .padding(1)
            }
            .padding()

            HStack {
                Button("", systemImage: "arrow.counterclockwise") {
                    // change boardText to "Rewinding..." for 3 seconds
                    changeBoardText(to: "Rewinding...")
                }
                .padding(10)
                Button("", systemImage: "arrow.left") {
                    // change boardText to "Undoing..." for 3 seconds
                    changeBoardText(to: "Undoing...")
                }
                .padding(10)
                Button("", systemImage: "arrow.right") {
                    // change boardText to "Redoing..." for 3 seconds
                    changeBoardText(to: "Redoing...")
                }
                .padding(10)
                Button("Hint") {
                    // change boardText to "Providing hint..." for 3 seconds
                    changeBoardText(to: "Providing hint...")
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
            HStack {
                Button("End") {
                    // Connect to LevelView
                    path.removeLast()
                }
                .buttonStyle(.bordered)
                Button("Score") {
                    showScoreView.toggle()
                }
                .buttonStyle(.bordered)
                .sheet(
                    isPresented: $showScoreView,
                    content: {
                        ScoreView(path: $path)
                    }
                )
            }
            Spacer()
            Text("Ads")
        }
    }
    /// Temporarily change `boardText` to a message and revert back after 3 seconds.
    /// - Parameters:
    ///   - temporary: String user wants `boardText` to change into.
    ///   - duration: Number of delayed seconds (Default: 3 seconds)
    func changeBoardText(to temporary: String, duration: TimeInterval = 3) {
        boardText = temporary
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            boardText = "Board"
        }
    }
}

#Preview {
    @Previewable @State var path = [Screen]()
    GameBoardView(path: $path)
}
