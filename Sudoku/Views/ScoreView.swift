//
//  ScoreView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// - Type: Action Sheet
/// - 1개의 Button을 갖는다
///     - End - GameHomeView 열기 또는 dismiss()
struct ScoreView: View {
    var body: some View {
        VStack {
            Text("Final Score")
                .font(.title)
                .bold()
            Spacer()
            Text("Scores:")
            Spacer()
            Button("Home") {
                // Connect to GameHomeView
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ScoreView()
}
