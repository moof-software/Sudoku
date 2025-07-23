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

enum Screen {
    case levelView
    case solverView
    case boardView
    case solutionView
}

struct GameHomeView: View {

    @State private var path: [Screen] = []

    @State private var showAboutView: Bool = false
    @State private var showLeaderView: Bool = false
    @State private var showSettingView: Bool = false

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    // About Button -> AboutView()
                    Button("", systemImage: "info.circle") {
                        // Connect to About Page
                        showAboutView.toggle()
                    }
                    .padding()
                    .sheet(
                        isPresented: $showAboutView, content: {
                            AboutView()
                        })

                    Spacer()

                    // Help Button -> HelpView()
                    NavigationLink {
                        HelpView()
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }
                    .padding()
                }

                Spacer()

                // Game Button -> LevelView()
                Button("Game") {
                    // Connect to Game page
                    path.append(.levelView)
                }
                .buttonStyle(.bordered)

                // Solver Button -> SolverView()
                Button("Solver") {
                    // Connect to Solver Page
                    path.append(.solverView)
                }
                .buttonStyle(.bordered)

                // Ads
                Text("Ads")

                Spacer()

                HStack {
                    // Leaderboard Button -> LeaderBoardView()
                    Button("", systemImage: "chart.bar.xaxis") {
                        // Connect to Leaderboard Page
                        showLeaderView.toggle()
                    }
                    .padding()
                    .sheet(
                        isPresented: $showLeaderView, content: {
                            LeaderBoardView()
                        })

                    Spacer()

                    // Setting Button -> SettingView()
                    Button("", systemImage: "gear") {
                        // Connect to Setting Page
                        showSettingView.toggle()
                    }
                    .padding()
                    .sheet(
                        isPresented: $showSettingView, content: {
                            SettingView()
                        })
                }
            }
            .navigationDestination(for: Screen.self, destination: { view in
                switch view {
                case .levelView:
                    LevelView(path: $path)
                case .solverView:
                    SolverView(path: $path)
                case .boardView:
                    GameBoardView(path: $path)
                        .navigationBarBackButtonHidden(true)
                case.solutionView:
                    SolutionView(path: $path)
                        .navigationBarBackButtonHidden(true)
                }
            })
        }
    }
}

#Preview {
    GameHomeView()
}
