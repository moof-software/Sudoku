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
            Button(String(localized: "Manual")) {
                // Connect to Solution Screen
                path.append(.solutionView)
            }
            Button(String(localized: "Camera")) {
                // TBD
            }
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var path = [Screen]()
    SolverView(path: $path)
}
