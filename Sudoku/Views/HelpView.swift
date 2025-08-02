//
//  HelpView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/15/25.
//

import SwiftUI

/// View that shows a Sudoku tutorial for first-time users.
/// - VStack
///     - ScrollView(horizontal)
///         - LazyHStack(Spacing:0)
///             - Images put in using ForEach
///                 - Modifiers: resizeable, scaled to
///                 fit, container relative frame
///                 adjusted for horizontal, count and span 1.
///         - Modifier: Scroll to Target Layout
///     - Modifiers: Scroll to Target Behavior(paging),
///     Scroll Position(with ID), Scroll Indicators (set to never)
///     - Text that shows page/all page number

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
