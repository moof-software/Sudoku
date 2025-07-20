//
//  SettingView.swift
//  Sudoku
//
//  Created by Jisu Lim on 7/15/25.
//

import SwiftUI

/// - Type: Action Sheet
/// - 1개의 Button을 갖는다
///     - Tile: Home
///     - Action: GameHomeView 열기 또는 dismiss()
struct SettingView: View {

    @State private var soundOn: Bool = true
    @State private var selectedEffect = 1
    @State private var selectedPattern = 2

    var body: some View {
        VStack {
            HStack {
                Button("< Back") {
                    // Connect to GameHomeView
                }
                .padding()
                Spacer()
            }
            Text("Settings")
                .font(.headline)
            Spacer()
            Section {
                Toggle("Sound", isOn: $soundOn)
                    .padding()
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
            }
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
