//
//  HapticManager.swift
//  Sudoku
//
//  Created by Jisu Lim on 10/29/25.
//

import Foundation
import SwiftUI

/// Class for managing haptics/vibrations throughout the game.
///
/// - Parameters:
///     - instance: static constant that takes in its class (singleton pattern)
///
/// - Methods:
///     - `notifictation(type:)`
///         - Function: demonstrates vibrations based on error, success, and warning
///     - `impact(style:)`
///         - Function: demonstrates vibrations based on strongness.
///         - soft, light, medium, rigid, heavy
class HapticManager {
    static let instance = HapticManager() // singleton
    
    /// Function for haptics based on notification.
    /// - Logic:
    ///     - creates a generator and calls notification has happened on said generator.
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    /// Function for haptics based on impact.
    /// - Logic:
    ///     - creates a generator and calls feedback has happened on said generator.
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
