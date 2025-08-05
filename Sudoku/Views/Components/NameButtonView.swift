//
//  NameButtonView.swift
//  Sudoku
//
//  Created by Hungu Lim on 8/5/25.
//

import SwiftUI

struct NameButtonView: View {
    let title: String
    let size: Int
    var body: some View {
        Text(title)
            .font(.custom("Chalkduster", size: CGFloat(size)))
    }
}

#Preview {
    NameButtonView(title: "Name", size: 32)
}
