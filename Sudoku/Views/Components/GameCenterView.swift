//
//  GameCenterView.swift
//  Sudoku
//
//  Created by Hungu Lim on 9/26/25.
//

import GameKit
import SwiftUI

struct GameCenterView: UIViewControllerRepresentable {
    let state: GKGameCenterViewControllerState  // .leaderboards or .leaderboard

    func makeUIViewController(context: Context) -> GKGameCenterViewController {
        let viewController = GKGameCenterViewController(state: state)
        viewController.gameCenterDelegate = context.coordinator  // Set the delegate
        return viewController
    }

    func updateUIViewController(
        _ uiViewController: GKGameCenterViewController,
        context: Context
    ) {
        // No updates needed for this view controller
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, GKGameCenterControllerDelegate {
        var parent: GameCenterView

        init(_ parent: GameCenterView) {
            self.parent = parent
        }

        func gameCenterViewControllerDidFinish(
            _ gameCenterViewController: GKGameCenterViewController
        ) {
            gameCenterViewController.dismiss(animated: true, completion: nil)
        }
    }
}

#Preview {
    GameCenterView(state: .default)
}
