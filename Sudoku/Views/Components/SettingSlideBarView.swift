//
//  SettingSlideBarView.swift
//  Sudoku
//
//  Created by Hungu Lim on 9/3/25.
//

import SwiftUI

struct SettingSlideBarView: View {
    @State private var slideBarValue = 5.0
    @State private var toggle = true

    var imageName: String
    var title: String
    var description: String
    var sliderType: Bool
    @Binding var data: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: imageName)
                    .frame(width: 32, alignment: .center)
                Text(title)
                    .frame(width: sliderType ? 150 : 200, alignment: .leading)
                if sliderType == true {
                    Slider(
                        value: $slideBarValue,
                        in: 1...10
                    ) {
                        Text("Volume")
                    } minimumValueLabel: {
                        Image(systemName: "minus")
                    } maximumValueLabel: {
                        Image(systemName: "plus")
                    }
                } else {
                    Spacer()
                    Toggle("toggle", isOn: $data)
                        .labelsHidden()
                }
            }
            .padding(.horizontal)
            HStack {
                Spacer()
                    .frame(width: 40)
                Text(description)
                    .multilineTextAlignment(.leading)
                    .font(.caption)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    @Previewable @State var toggle = true
    SettingSlideBarView(
        imageName: "music.quarternote.3",
        title: "Melody Volume",
        description: "Move slider to change the volume of the melody",
        sliderType: false,
        data: $toggle
    )
    .environmentObject(Sudoku())
}
