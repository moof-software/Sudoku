//
//  GameBoardView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftData
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
    @Environment(\.modelContext) var modelContext
    @Query var sudokus: [Sudoku]
    @Binding var path: [Screen]

    // Score text will change according to some buttons being pressed
    @State var scoreText: String = String(localized: "Score")
    // toggling ScoreView as a sheet (temp)
    @State private var showScoreView: Bool = false
    // toggling Number Pad to Memo
    @State private var memoToggled: Bool = false

    var body: some View {
        VStack {
            HStack {
                //            - Text: "Errors"
                //                - Font: Custom font "Chalkduster", size: 18
                Text(String(localized: "Errors"))
                    .font(.custom("Chalkduster", size: 18))
                    .padding()
                Spacer()
                //            - Text: scoreText
                //                - Font: Custom font "Chalkduster", size: 18
                Text(scoreText)
                    .font(.custom("Chalkduster", size: 18))
                    .padding()
                Spacer()
                //            - Text: "Time"
                //                - Font: Custom font "Chalkduster", size: 18
                Text(String(localized: "Time"))
                    .font(.custom("Chalkduster", size: 18))
                    .padding()
            }
            Spacer()
            //        - ZStack(alignment: center)
            //            - Rounded Rectangle (cornerRadius 4)
            //                - Frame: width and height infinity
            //                - Background: gray, opacity 0.2
            //                - ForegroundStyle: gray, opacity 0.2
            //                - aspectRatio: 1.0, contentMode: fit
            //        - Board() with padding 1
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
                //            - Button: Rewind (label: arrow.counterclockwise)
                //                - Action: changeBoardText("Rewinding...")
                //                - Padding: 10
                Button {
                    // change boardText to "Rewinding..." for 3 seconds
                    changeBoardText(to: String(localized: "Restart"))
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
                .padding(10)
                //            - Button: Undo (label: arrow.left)
                //                - Action: changeBoardText("Undoing...")
                //                - Padding: 10
                Button {
                    // change boardText to "Undoing..." for 3 seconds
                    changeBoardText(to: String(localized: "Undoing..."))
                } label: {
                    Image(systemName: "arrow.left")
                }
                .padding(10)
                //            - Button: Redo (label: arrow.right)
                //                - Action: changeBoardText("Redoing...")
                //                - Padding: 10
                Button {
                    // change boardText to "Redoing..." for 3 seconds
                    changeBoardText(to: String(localized: "Redoing..."))
                } label: {
                    Image(systemName: "arrow.right")
                }
                .padding(10)
                //            - Button: Hint (label: "Hint" with custom font
                //                "Chalkduster" pt 18)
                //                - Action: changeBoardText("Providing Hint...")
                //                - Padding: 10
                Button {
                    // change boardText to "Providing hint..." for 3 seconds
                    changeBoardText(to: String(localized: "Hint"))
                } label: {
                    Text(String(localized: "Hint"))
                        .font(.custom("Chalkduster", size: 18))
                }
                .padding(10)
                Spacer()
                //            - Button: Memo (label: pencil)
                //                - Action: Toggle memoToggled
                //                - Padding: 10
                Button("", systemImage: "pencil") {
                    // change numberpadText to "Memo"
                    memoToggled.toggle()
                }
                .padding(10)
            }
            //        - Text
            //            - Conditional operator relying on memoToggled
            //            - if memoToggled = True, set to "Memo"
            //            - if memoToggled = False, set to "Number Pad"
            //            - Frame: maxWidth infinity, maxHeight 70
            //            - Background: gray, opacity 0.2
            if memoToggled {
                Text(String(localized: "Memo"))
                    .frame(maxWidth: .infinity, maxHeight: 70)
                    .background(Color.gray.opacity(0.2))
            } else {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(maxWidth: .infinity, maxHeight: 70)
                        .foregroundStyle(Color.gray.opacity(0.2))

                    NumberPad()
                }
            }
            Spacer()
            HStack {
                //            - Button: End (label: "End" with custom font "Chalkduster" pt 18)
                //                - Action: remove last path (connect back to levelView)
                //                - Default padding
                Button {
                    // Connect to LevelView
                    path.removeLast()
                    if !sudokus.isEmpty {
                        modelContext.delete(sudokus[0])
                    }
                } label: {
                    Text(String(localized: "End"))
                        .font(.custom("Chalkduster", size: 18))
                }
                .padding()
                //            Button: Score (label: "Score" with custom font "Chalkduster" pt 18)
                //                - Action: toggle showScoreView(showing ScoreView sheet)
                //                - Default padding
                //                - .sheet to present ScoreView (must connect path)
                Button {
                    showScoreView.toggle()
                } label: {
                    Text(String(localized: "Score"))
                        .font(.custom("Chalkduster", size: 18))
                }
                .padding()
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
        scoreText = temporary
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            scoreText = String(localized: "Score")
        }
    }
}

#Preview {
    @Previewable @State var path = [Screen]()
    GameBoardView(path: $path)
}
