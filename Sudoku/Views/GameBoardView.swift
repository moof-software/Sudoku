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
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var sudoku: Sudoku
    @Binding var path: [Screen]

    // toggling ScoreView as a sheet (temp)
    @State private var showScoreView: Bool = false
    // @State private var hintState: Bool = false
    // toggling Number Pad to Memo
    @State private var memoToggled: Bool = false

    var body: some View {
        VStack {
            BoardHeaderView()
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

                BoardView()
                    .padding(1)
            }
            .padding()

            HStack {
                //            - Button: Rewind (label: arrow.counterclockwise)
                //                - Action: changeBoardText("Rewinding...")
                //                - Padding: 10
                Button {

                    //                    if let sudoku = sudokus.last {
                    sudoku.table.cell[0][0].value = 1
                    sudoku.table.cell[0][0].visible = true
                    //                    }
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
                .padding(20)
                //            - Button: Undo (label: arrow.left)
                //                - Action: changeBoardText("Undoing...")
                //                - Padding: 10
                Button {

                } label: {
                    Image(systemName: "arrow.left")
                }
                .padding(10)
                //            - Button: Redo (label: arrow.right)
                //                - Action: changeBoardText("Redoing...")
                //                - Padding: 10
                Button {

                } label: {
                    Image(systemName: "arrow.right")
                }
                .padding(10)
                //            - Button: Hint (label: "Hint" with custom font
                //                "Chalkduster" pt 18)
                //                - Action: changeBoardText("Providing Hint...")
                //                - Padding: 10
                Spacer()
                Button {

                    // hintState.toggle()
                    //                    if let lastSudoku = sudokus.last {
                    sudoku.showHint = sudoku.showHint ? false : true
                    //                    }
                } label: {
                    Text(String(localized: "Hint"))
                        .font(.custom("Chalkduster", size: 18))
                }
                .padding(20)
                //            - Button: Memo (label: pencil)
                //                - Action: Toggle memoToggled
                //                - Padding: 10
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
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundStyle(Color.gray.opacity(0.2))
                        .padding(4)
                    HStack(spacing: 2) {
                        ForEach(0..<9, id: \.self) { index in
                            NumberPadView(
                                index: index,
                                isPresented: $showScoreView
                            )
                        }
                    }
                    .padding()
                }

            }
            Spacer()
            //            Text(
            //                """
            //                Completed RCB: 0 Combos: 0 Hints: 0 Undo: 0
            //                Basic Score: 0 Deductions: 0
            //                Add Score:0 Combo Score: 0
            //                """
            //            )
            //            .font(.caption)
            //            .multilineTextAlignment(.leading)
            //            .padding(.horizontal)
            HStack {
                //            - Button: End (label: "End" with custom font "Chalkduster" pt 18)
                //                - Action: remove last path (connect back to levelView)
                //                - Default padding
                Button {
                    // Connect to LevelView
                    path.removeLast()
                    sudoku.initSudoukuBoard()
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
            AdBannerView()
        }
        .statusBarHidden(sudoku.setting.showStatusBar ? false : true)
        .environmentObject(sudoku)
        //        .onAppear {
        //            sudoku.startScoreCounter()
        //        }
        .onAppear {
            AudioManager.instnace.prepareBGSound()
            AudioManager.instnace.playBGsound()
        }
        .onDisappear {
            sudoku.setScoreCounter(pause: true)
            AudioManager.instnace.stopBGsound()
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                sudoku.setScoreCounter(pause: false)
            } else {
                sudoku.setScoreCounter(pause: true)
            }
        }
    }
}

#Preview {
    @Previewable @State var path = [Screen]()
    GameBoardView(path: $path)
        .environmentObject(Sudoku())
}
