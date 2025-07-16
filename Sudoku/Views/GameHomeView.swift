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
        Text("Sudoku Home View")
    }

}

#Preview {
    GameHomeView()
}
