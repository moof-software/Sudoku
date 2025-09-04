//
//  SettingView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// View that lets users set sounds, effects, and tile patterns.
///
/// Contains:
/// - VStack
///     - HStack
///         - Back Button
///             - Label: "< Back"
///             - Action: Connect to GameHomeView
///     - "Settings" Text
///     - Section
///         - Sound Toggle
///             - Label:  "Sound"
///             - Action: TBD
///     - Section
///         - Effects Picker
///             - Label:  "Effect"
///             - Picker Style: 3 segments
///             - Action: TBD
///     - Section
///         - Tile Pattern Picker
///             - Label:  "Tile Pattern"
///             - Picker Style: 3 segments
///             - Action: TBD
struct SettingView: View {
    @Environment(\.dismiss) var dismiss

    @State private var soundOn: Bool = true
    @State private var selectedEffect = 1
    @State private var selectedPattern = 2

    var body: some View {
        VStack {
            // Sound Section
            Section("Sounds") {
                SettingSlideBarView(
                    imageName: "music.quarternote.3",
                    title: "Melody Volume",
                    description:
                        "Move slider to change the volume of the melody",
                    sliderType: true
                )
                SettingSlideBarView(
                    imageName: "waveform.path",
                    title: "Effects Volume",
                    description:
                        "Move slider to change the volume of the effects",
                    sliderType: true
                )
            }
            .padding(.vertical, 4)
            // Effect Section
            Section("Game") {
                SettingSlideBarView(
                    imageName: "square",
                    title: "Use Auto-Select",
                    description:
                        "After a tile match, auto-select all tiles with the same number",
                    sliderType: false
                )
                SettingSlideBarView(
                    imageName: "square.grid.3x3.middle.filled",
                    title: "Use Level Best Score",
                    description:
                        "At game end, compare scores using level best score instead of the overall best",
                    sliderType: false
                )
            }
            .padding(.vertical, 4)
            // Tile Pattern Section
            Section("Interface") {
                SettingSlideBarView(
                    imageName: "battery.75percent",
                    title: "Show Status Bar",
                    description:
                        "Always show status bar when playing a game",
                    sliderType: false
                )
                SettingSlideBarView(
                    imageName: "timer",
                    title: "Hide Timer",
                    description:
                        "Hide timer while playing (total time shown at the end of session)",
                    sliderType: false
                )
            }
            .padding(.vertical, 4)
            Section("Advanced") {
                SettingSlideBarView(
                    imageName: "gamecontroller.circle",
                    title: "Game Center",
                    description:
                        "Enable the Game Center for leaderboards and score uploads",
                    sliderType: false
                )
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    SettingView()
}
