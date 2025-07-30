//
//  IconNameButtonView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/30/25.
//

import SwiftUI

/// Button Types: IconNameButtonView
///
/// NameButton:
///     Label:
///         VStack
///             Image
///             Text
///         Modifiers:
///             frame (width 200, height 80)
/// background
///     RoundedRectangle with cornerRadius 25
///         stroke in accentColor, linewidth 4
struct IconNameButtonView: View {
    let icon: String
    let title: String
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: icon)
                .renderingMode(.original)

            Text(title)
                .fontWeight(.semibold)
        }
        .frame(width: 200, height: 80)
        .background {
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.accentColor, lineWidth: 4)
        }
    }
}

#Preview {
    IconNameButtonView(icon: "gamecontroller.fill", title: "Game")
    IconNameButtonView(icon: "wand.and.sparkles", title: "Solver")
}
