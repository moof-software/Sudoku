//
//  GameBoardView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// - Type: Navigation Stack
/// - Open시 항상 LevelView를 표시한다.
/// - (임시)1개의 Label을 갖는다
///     - Title: Level
///     - LevelView에서 선택한 값을 표시한다.
/// - (임시)1개의 Button을 갖는다
///     - Tile: End
///     - Action: ScoreView 열기 또는 dismiss()
struct GameBoardView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    GameBoardView()
}
