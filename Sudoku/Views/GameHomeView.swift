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
    enum Sheet: String, Identifiable {
        case showAboutView, showLedaerView, showSettingView

        var id: String { rawValue }
    }

    @State private var presentedSheet: Sheet?

    var body: some View {
        VStack {
            HStack {
                Button("", systemImage: "info.circle") {
                    // Connect to About Page
                    presentedSheet = .showAboutView
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
                    presentedSheet = .showLedaerView
                }
                .padding()

                Spacer()
                Button("", systemImage: "gear") {
                    // Connect to Setting Page
                    presentedSheet = .showSettingView
                }
                .padding()
            }
        }
        .sheet(item: $presentedSheet, content: { sheet in
            switch sheet {
            case .showAboutView:
                AboutView()
            case .showLedaerView:
                LeaderBoardView()
            case .showSettingView:
                SettingView()
            }
        })
    }

}

#Preview {
    GameHomeView()
}
