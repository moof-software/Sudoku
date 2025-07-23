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
            Spacer()
            // Sound Section
            Section {
                Toggle("Sound", isOn: $soundOn)
                    .padding()
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
            }
            // Effect Section
            Section {
                Picker("Effect", selection: $selectedEffect) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                }
                .padding(.horizontal)
                .pickerStyle(.segmented)
            } header: {
                HStack {
                    Text("Effect")
                        .padding(.horizontal)
                    Spacer()
                }
            }
            // Tile Pattern Section
            Section {
                Picker("Tile Pattern", selection: $selectedPattern) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            } header: {
                HStack {
                    Text("Tile Pattern")
                        .padding(.horizontal)
                    Spacer()
                }
            }
            Spacer()
        }
    }
}

#Preview {
    SettingView()
}
