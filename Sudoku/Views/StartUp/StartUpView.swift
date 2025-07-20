//
//  StartUpView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/16/25.
//

import SwiftUI

/// ``StartUpView``
/// ```swift
/// Text("Sudoku")
///    .font(.largeTitle)
///    .fontWeight(.heavy)
///    .foregroundStyle(Color.black)
///    .shadow(color: .black, radius: 10)
/// ```
struct StartUpView: View {

    /// Startup view를 화면에 표시 여부를 Bool값으로 @Binding으로 받는 showStartUpView
    @Binding var showStartUpView: Bool

    @State private var loadingString: [String] = "Loading your sudoku game data...".map { String($0) }
    @State private var showLoadingString: Bool = false
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var stringCounter: Int = 0
    @State private var timerLoops: Int = 0
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            Text("Sudoku")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(Color.black)
                .shadow(color: .black, radius: 10)

            ZStack {
                if showLoadingString {
                    HStack(spacing: 0) {
                        ForEach(loadingString.indices) { index in
                            Text(loadingString[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.black)
                                .shadow(color: .black, radius: 10)
                                .offset(x: stringCounter == index ? 10 : 0, y: stringCounter == index ? -15 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoadingString.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring()) {
                if stringCounter == (loadingString.count - 1) {
                    stringCounter = 0
                    timerLoops += 1
                    if timerLoops >= 2 {
                        showStartUpView = false
                    }
                } else {
                    stringCounter += 1
                }
            }
        })
    }
}

#Preview {
    StartUpView(showStartUpView: .constant(true))
}
