//
//  SolverView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// View that provides which solver tool is needed for the user ( Manual or Camera)
///
/// Contains:
/// - VStack
///     - HStack
///         - Back Button
///             - Label: "< Back"
///             - Action: Connect to GameHomeView
///     - Manual Button
///         - Label: "Manual"
///         - Action: Connect to SolutionView
///     - Camer Button
///         - Label: "Camera"
///         - Action: TBD
struct SolverView: View {
    var body: some View {
        VStack {
            HStack {
                Button("< Back") {
                    // Connect to GameHomeView
                }
                .padding()
                Spacer()
            }
            Spacer()
            Button("Manual") {
                // Connect to Solution Screen
            }
            Button("Camera") {
                // TBD
            }
            Spacer()
        }
    }
}

#Preview {
    SolverView()
}
