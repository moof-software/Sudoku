//
//  ContentView.swift
//  Sudoku
//
//  Created by Hyunsu Lim on 7/14/25.
//

import SwiftUI

/// View containing About, Help, Game, Solver, LeaderBoard, and Setting buttons.
///
/// Contains:
/// - VStack
///     - HStack
///         - About Button
///             - Label: info.circle system image
///             - Action: Connect to AboutView
///         - Help Button
///             - Label: questionmark.circle system image
///             - Action: Connect to HelpView
///     - Game Button
///         - Label: "Game"
///         - Action: Connect to LevelView
///     - Solver Button
///         - Label: "Solver"
///         - Action: Connect to SolverView
///     - "Ads" Text
///     - HStack
///         - Leaderboard Button
///             - Label: chart.bar.xaxis system image
///             - Action: Connect to LeaderboardView
///         - Setting Button
///             - Label: gear system image
///             - Action: Connect to SettingView
struct GameHomeView: View {

    var body: some View {
        VStack {
            HStack {
                Button("", systemImage: "info.circle") {
                    // Connect to About Page
                }
                .padding()
                Spacer()
                Button("", systemImage: "questionmark.circle") {
                    // Connect to Help Page
                }
                .padding()
            }
            Spacer()
            Button("Game") {
                // Connect to Level Page
            }
            .buttonStyle(.bordered)
            Button("Solver") {
                // Connect to Solver Page
            }
            .buttonStyle(.bordered)
            Text("Ads")
            Spacer()
            HStack {
                Button("", systemImage: "chart.bar.xaxis") {
                    // Connect to Leaderboard Page
                }
                .padding()
                Spacer()
                Button("", systemImage: "gear") {
                    // Connect to Setting Page
                }
                .padding()
            }
        }
    }

}

#Preview {
    GameHomeView()
}
