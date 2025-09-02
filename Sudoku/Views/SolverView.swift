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
    @Binding var path: [Screen]

    var body: some View {
        VStack {
            Spacer()
            Button {
                // Connect to Solution page
                path.append(.solutionView)
            } label: {
                IconNameButtonView(
                    icon: "square.grid.3x3.topleft.filled",
                    title: String(localized: "Manual")
                )
            }

            // Solver Button -> SolverView()
            Button {
                // Connect to Solver Page
                path.append(.solutionView)
            } label: {
                IconNameButtonView(
                    icon: "camera.fill",
                    title: String(localized: "Camera")
                )
            }
            .disabled(true)
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var path = [Screen]()
    SolverView(path: $path)
}
