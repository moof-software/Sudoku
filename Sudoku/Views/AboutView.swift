//
//  AboutView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/15/25.
//

import SwiftUI

/// View that contains information regarding versions, developers, and licenses.
///
/// Contains:
/// - VStack
///     - HStack
///         - Back Button
///             - Label: " < Back "
///             - Action: Connects to GameHomeView
///     - Text containing version information
///     - Text containing developers information
///     - Text containing GNU license information
///     - Easter Egg Button
///         - Label: " Easter Egg Placeholder " with fun symbols surrounding it
///         - Action: TBD

struct AboutView: View {
    var body: some View {
        VStack {
            Spacer()
            // Version Info
            Text("Version Info: ")
                .padding()
            // Developers Info
            Text("Developers Info: ")
                .padding()
            // License Info
            Text("GNU License Info: ")
                .padding()
            Spacer()
            // Easter Egg
            Button("Easter Egg Placeholder", systemImage: "sparkles") {
                // will add Easter Egg Content later
            }
        }
    }
}

#Preview {
    AboutView()
}
