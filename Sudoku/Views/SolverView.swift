//
//  SolverView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// - Type: Navigation Stack
/// - 1개의 NavigationBarItem을 갖는다
///     - Title: Home
///     - GameHomeView 열기.
/// - 1개의 Button을 갖는다
///     - Tile: Manual
///     - Action: SolutionView 열기 또는 dismiss()
struct SolverView: View {
    var body: some View {
        VStack {
            HStack {
                Button("< Back") {
                    // Connect to GameHomeView
                }
                .padding()
                Spacer()
            }
            Spacer()
            Button("Manual") {
                // Connect to Solution Screen
            }
            Button("Camera") {
                // TBD
            }
            Spacer()
        }
    }
}

#Preview {
    SolverView()
}
