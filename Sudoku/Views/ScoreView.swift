//
//  ScoreView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// View that shows the final scores.
///
/// Contains:
/// - VStack
///     - "Final Score" Text
///     - "Scores:" Text
///     - Home Button
///         - Label: "Home"
///         - Action: Connect to GameHomeView
struct ScoreView: View {
    @Binding var path: [Screen]
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var sudoku: Sudoku
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        ScoreListItemView(
                            title: "Basic Score",
                            value: 0,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Deductions",
                            value: 0,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Extra Score",
                            value: 0,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Combo Score",
                            value: 0,
                            bold: false
                        )

                        ScoreListItemView(
                            title: "Total",
                            value: sudoku.score.total,
                            bold: true
                        )
                    }
                    Section {
                        ScoreListItemView(
                            title: "Level",
                            value: sudoku.score.level.rawValue,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Time",
                            value: sudoku.score.time,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Errors",
                            value: sudoku.score.errors,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Multiplier",
                            value: sudoku.score.multiplier,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Completed R.C.B.",
                            value: sudoku.score.completedRCB,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Combos",
                            value: 0,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Hints",
                            value: 0,
                            bold: false
                        )
                        ScoreListItemView(
                            title: "Undo",
                            value: 0,
                            bold: false
                        )
                    }
                }

                Spacer()
                Button("Home") {
                    // Connect to GameHomeView
                    dismiss()
                    path.removeLast()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Final Score")
        }
    }
}

#Preview {
    @Previewable @State var path = [Screen]()
    ScoreView(path: $path)
        .environmentObject(Sudoku())
}
