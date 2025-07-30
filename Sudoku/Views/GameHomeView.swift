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
    
    
    
    
    
    /// About Button: IconButton with label as SystemImage “info.circle,” location top left not ignoring safe area.
    /// Help Button: IconButton with label as SystemImage “question.circle,” location top right not ignoring safe area.
    /// Game Button: NameButton with label as SystemImage “gamecontroller.fill” and text as “Game”, location center above Solver Button
    /// Solver Button: NameButton with label as SystemImage “wand.and.sparkles” and text as “Solver”, location center below Game Button
    /// Leaderboard Button: IconButton with label as SystemImage “chart.bar.xaxis,” location bottom left not ignoring safe area.
    /// Setting Button: IconButton with label as SystemImage “gearshape.fill,” location bottom right not ignoring safe area.
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    // About Button -> AboutView()
                    Button {
                        // Connect to About Page
                        showAboutView.toggle()
                    } label: {
                        IconButtonView(iconName: "info.circle")
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
//                        Image(systemName: "questionmark.circle")
                        IconButtonView(iconName: "questionmark.circle")
                    }
                    .padding()
                }

                Spacer()

                // Game Button -> LevelView()
                Button {
                    // Connect to Game page
                    path.append(.levelView)
                } label: {
                    IconNameButtonView(icon: "gamecontroller.fill", title: "Game")
                }

                // Solver Button -> SolverView()
                Button {
                    // Connect to Solver Page
                    path.append(.solverView)
                } label: {
                    IconNameButtonView(icon: "wand.and.sparkles", title: "Solver")
                }

                // Ads
                Text("Ads")

                Spacer()

                HStack {
                    // Leaderboard Button -> LeaderBoardView()
                    Button {
                        // Connect to Leaderboard Page
                        showLeaderView.toggle()
                    } label: {
                        IconButtonView(iconName: "chart.bar.xaxis")
                    }
                    .padding()
                    .sheet(
                        isPresented: $showLeaderView, content: {
                            LeaderBoardView()
                        })

                    Spacer()

                    // Setting Button -> SettingView()
                    Button {
                        // Connect to Setting Page
                        showSettingView.toggle()
                    } label: {
                        IconButtonView(iconName: "gear")
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
