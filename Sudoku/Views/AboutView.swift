//
//  AboutView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/15/25.
//

import SwiftUI

/// View that contains information regarding versions, developers, and licenses.
///
///
/// - Parameters:
///     - example: description
/// - Returns:A view containing information on a typical About View.
/// - Throws: Throwing message.
/// - Note: This is a note.
/// - Warning: This is a warning message.
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
///
/// Example:
/// ```swift
/// GreetingView(message: "Hi!", fontSize: 24)
/// ```

struct AboutView: View {
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
            Text("Version Info: ")
                .padding()
            Text("Developers Info: ")
                .padding()
            Text("GNU License Info: ")
                .padding()
            Spacer()
            Button("Easter Egg Placeholder", systemImage: "sparkles") {
                // will add Easter Egg Content later
            }
        }
    }
}

#Preview {
    AboutView()
}
