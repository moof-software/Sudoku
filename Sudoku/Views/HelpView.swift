//
//  HelpView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/15/25.
//

import SwiftUI

/// View that shows a Sudoku tutorial for first-time users.
/// - Scrollview (horizontal, width 343 height 635)
///    - HStack
///        - Images
/// - Modifier: scrollTargetBehavior(viewAligned)

struct HelpView: View {
    @State private var scrolledID: Int? = 0
    private var images: [Image] = [
        Image("HelpView"),
        Image("HelpView"),
        Image("HelpView"),
        Image("HelpView")
    ]

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<images.count, id: \.self) { index in
                        images[index]
                            .resizable()
                            .scaledToFit()
                            .containerRelativeFrame(.horizontal, count: 1, span: 1, spacing: 0, alignment: .center)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $scrolledID)
            .scrollIndicators(.never)

            Text("\(scrolledID ?? 0)/\(images.count - 1)")
                .padding()
        }
    }
}

#Preview {
    HelpView()
}
