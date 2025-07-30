//
//  IconButtonView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/30/25.
//

import SwiftUI

/// Button Types: IconButton
///
/// IconButton:
/// Label: Image
///     Modifiers:
///         resizeable
///         frame (width 30, height 30)
/// button padding default (16)
struct IconButtonView: View {
    let iconName: String

    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .frame(width: 30, height: 30, alignment: .center)
    }
}

#Preview {
    IconButtonView(iconName: "info.circle")
}
