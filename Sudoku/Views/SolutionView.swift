//
//  SolutionView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//
import SwiftUI

/// View that provides an empty or partially filled Sudoku board that can be solved with a button.
///
/// Contains:
///
/// - VStack
///     - `solutionBoardText` Text
///         - Default must be "Board"
///     - Solve It Button
///         - Label: "Solve it!"
///         - Action: Changes `solutionBoardText` to "Solved"
///     - Home Button
///         - Label: "Home"
///         - Action: Connect to GameHomeView
struct SolutionView: View {

    @Binding var path: [Screen]
    @State private var solutionBoardText = "Board"
    @EnvironmentObject var sudoku: Sudoku

    var body: some View {
        VStack {
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
            Button("Solve it!") {
                // Changes board text
                solutionBoardText = "Solved!"
            }
            .buttonStyle(.bordered)
            Spacer()
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 4)
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .foregroundStyle(Color.gray.opacity(0.2))
                    .padding(4)
                HStack(spacing: 2) {
                    ForEach(0..<9, id: \.self) { index in
                        NumberPadView(
                            index: index
                        )
                    }
                }
                .padding()
            }
            Spacer()
            Spacer()
            Button {
                // Connect to GameHomeView
                path.removeAll()
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "gamecontroller.fill")
                        .renderingMode(.original)
                    Text(String(localized: "Game Home"))
                        .fontWeight(.semibold)
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.accentColor, lineWidth: 4)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var path = [Screen]()
    SolutionView(path: $path)
        .environmentObject(Sudoku())
}
