//
//  SettingView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

struct SettingPreference {
    @EnvironmentObject var sudoku: Sudoku

    var autoSelect: Bool = false
    var useLevelBestScore: Bool = false
    var showStatusBar: Bool = false
    var hideTimer: Bool = false
    var gameCenter: Bool = true
}

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
    @EnvironmentObject var sudoku: Sudoku

    @State private var soundOn: Bool = true
    @State private var selectedEffect = 1
    @State private var selectedPattern = 2

    var body: some View {
        VStack {
            // Sound Section
            Section(String(localized: "Sounds")) {
                SettingSlideBarView(
                    imageName: "music.quarternote.3",
                    title: String(localized: "Melody Volume"),
                    description:
                        String(
                            localized:
                                "Move slider to change the volume of the melody"
                        ),
                    sliderType: true,
                    data: $sudoku.setting.autoSelect
                )
                SettingSlideBarView(
                    imageName: "waveform.path",
                    title: String(localized: "Effects Volume"),
                    description:
                        String(
                            localized:
                                "Move slider to change the volume of the effects"
                        ),
                    sliderType: true,
                    data: $sudoku.setting.autoSelect
                )
            }
            .padding(.vertical, 4)
            // Effect Section
            Section(String(localized: "Game")) {
                SettingSlideBarView(
                    imageName: "square",
                    title: String(localized: "Use Auto-Select"),
                    description:
                        String(
                            localized:
                                "After a tile match, auto-select all tiles with the same number"
                        ),
                    sliderType: false,
                    data: $sudoku.setting.autoSelect
                )
                SettingSlideBarView(
                    imageName: "square.grid.3x3.middle.filled",
                    title: String(localized: "Use Level Best Score"),
                    description:
                        String(
                            localized:
                                "At game end, compare scores using level best score instead of the overall best"
                        ),
                    sliderType: false,
                    data: $sudoku.setting.useLevelBestScore
                )
            }
            .padding(.vertical, 4)
            // Tile Pattern Section
            Section(String(localized: "Interface")) {
                SettingSlideBarView(
                    imageName: "battery.75percent",
                    title: String(localized: "Show Status Bar"),
                    description:
                        String(
                            localized:
                                "Always show status bar when playing a game"
                        ),
                    sliderType: false,
                    data: $sudoku.setting.showStatusBar
                )
                SettingSlideBarView(
                    imageName: "timer",
                    title: String(localized: "Hide Timer"),
                    description:
                        String(
                            localized:
                                "Hide timer while playing (total time shown at the end of session)"
                        ),
                    sliderType: false,
                    data: $sudoku.setting.hideTimer
                )
            }
            .padding(.vertical, 4)
            Section(String(localized: "Advanced")) {
                SettingSlideBarView(
                    imageName: "gamecontroller.circle",
                    title: String(localized: "Game Center"),
                    description:
                        String(
                            localized:
                                "Enable the Game Center for leaderboards and score uploads"
                        ),
                    sliderType: false,
                    data: $sudoku.setting.gameCenter
                )
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    SettingView()
}
