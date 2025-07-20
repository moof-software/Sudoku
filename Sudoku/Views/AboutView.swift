//
//  AboutView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/15/25.
//

import SwiftUI

/// Type: Navigation Stack
///
/// - 1개의 NavigationBarItem을 갖는다
///     - Tile: Home
///     - Action: GameHomeView 열기
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
            Text("Version Info: Hello my name is Jisu Lim and I like Oreos and blondies. I am currently testing the version info text.")
                .padding()
            Text("Developers Info: Hello my name is Jisu Lim and I like Oreos and blondies. I am currently testing the developer info text.")
                .padding()
            Text("GNU License Info: Hello my name is Jisu Lim and I like Oreos and blondies. I am currently testing the GNU License info text.")
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
