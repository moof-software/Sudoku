//
//  HelpView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/15/25.
//

import SwiftUI

/// Type: Navigation Stack
///  - 1개의 NavigationBarItem을 갖는다
///     - Tile: Home
///     - Action: GameHomeView 열기
struct HelpView: View {

    @State private var displayedText = "Help Screen"

    var body: some View {
        VStack {
            HStack {
                Button("< Back") {
                    // Connect to GameHomeView
                }
                .padding()
                Spacer()
                Button("Next >") {
                    // Change text on screen to "Next Page"
                    displayedText = "Next Page"
                }
                .padding()
            }
            Spacer()
            Text(displayedText)
            Spacer()
        }
    }
}

#Preview {
    HelpView()
}
