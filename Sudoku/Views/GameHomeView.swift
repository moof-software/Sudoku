//
//  ContentView.swift
//  Sudoku
//
//  Created by Hyunsu Lim on 7/14/25.
//

import SwiftUI

/// 6개의 버튼이 필요하다.
/// - About - AboutView(NavigationStack type) 열기
/// - Help - HelpView(NavigationStack type) 열기
/// - Leader Board - LeaderBoardView(ActionSheet type) 열기
/// - Setting - SettingView(ActionSheet type) 열기
/// - Game- GameBoardView(NavigationStack type, 진입시 항상 LevelView ActionSheet type형 화면을 표시한다) 열기
/// - Solver - SolverView(NavigationStack type) 열기
///
/// - Parameters:
///     - x: The *x* component of the vector.
///     - y: The *y* component of the vector.
///     - z: The *z* component of the vector.
///
/// - Returns:
///     - a: The *a* component of the vector.
///
struct GameHomeView: View {

    var body: some View {
        VStack {
            /// HStack for top side buttons
            HStack {
                /// About button
                NavigationLink {
                    AboutView()
                } label: {
                    Image(systemName: "info.circle")
                }
                .padding()
                Spacer()
                /// Game Center button
                Button(action: gameCenterButtonAction) {
                    Text("Game Center")
                }
                .padding()
                Spacer()
                /// Help Button
                NavigationLink {
                    HelpView()
                } label: {
                    Image(systemName: "questionmark.circle")
                }
                .padding()
            }
            Spacer()
            Text("Sudoku Home View")
            /// VStack for middle buttons
            VStack {
                /// Game button
                NavigationLink {
                    LevelView()
                } label: {
                    Text("Game")
                }
                /// Solver Button
                NavigationLink {
                    SolverView()
                } label: {
                    Text("Solver")
                }
            }
            Spacer()
            /// HStack for bottom side buttons
            HStack {
                /// Leaderboard button
                NavigationLink {
                    LeaderBoardView()
                } label: {
                    Image(systemName: "chart.bar.fill")
                }
                .padding()
                Spacer()
                /// Settings button
                NavigationLink {
                    SettingView()
                } label: {
                    Image(systemName: "gearshape.fill")
                }
                .padding()
            }
        }
    }

    private func gameCenterButtonAction() { }
}

#Preview {
    GameHomeView()
}
