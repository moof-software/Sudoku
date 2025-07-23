//
//  HelpView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/15/25.
//

import SwiftUI

/// View that shows a Sudoku tutorial for first-time users.
///
/// Contains:
/// - VStack
///     - HStack
///         - Back Button
///             - Label: "< Back"
///             - Action: Connect to GameHomeView
///         - Next Button
///             - Label: "Next >"
///             - Action: Change `displayedText` to "Next Page"
///     - `displayedText` Text
///         - Default must be "Help Screen"
struct HelpView: View {

    var body: some View {
        VStack {
            Spacer()
            // Help Screen
            Text("Help Screen")
            Spacer()
        }
    }
}

#Preview {
    HelpView()
}
