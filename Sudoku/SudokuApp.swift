//
//  SudokuApp.swift
//  Sudoku
//
//  Created by Hyunsu Lim on 7/14/25.
//

import SwiftUI

@main
struct SudokuApp: App {
    /// ``showStartUpView``를 bool type으로 선언하고 default 값으로 `true`값을 지정한 한다.
    @State private var showStartUpView: Bool = true

    /// ZStack으로 ``GameHomeView``와 ``StartUpView``를 화면에 표시한다.
    var body: some Scene {
        WindowGroup {
            /// ZStack으로 ``GameHomeView``와 ``StartUpView``를 화면에 표시한다.
            ZStack {
                NavigationStack {

                    GameHomeView()
                        .toolbar(.hidden)
                }

                ZStack {
                    if showStartUpView {
                        StartUpView(showStartUpView: $showStartUpView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
