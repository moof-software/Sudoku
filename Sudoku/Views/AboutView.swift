//
//  AboutView.swift
//  Sudoku
//
//  Created by Hungu Lim on 7/15/25.
//

import SwiftUI

/// View that contains information regarding versions, developers, and licenses.
///
/// Contains:
/// - VStack
///     - HStack
///         - Back Button
///             - Label: " < Back "
///             - Action: Connects to GameHomeView
///     - Text containing version information
///     - Text containing developers information
///     - Text containing GNU license information
///     - Easter Egg Button
///         - Label: " Easter Egg Placeholder " with fun symbols surrounding it
///         - Action: TBD

struct AboutView: View {
    private var version: String {
        if let ver = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return ver
        } else {
            return "Unknown"
        }
    }

    private var buildNumber: String {
        if let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
            return build
        } else {
            return "0"
        }
    }

    var body: some View {

        VStack {
            /// - titleLabel (width 230, height 115)
            ///    - Type: Text
            ///    - Text: "Ultimate Sudoku Pro" ( localized from Localizable )
            ///    - Font: Chalkduster
            ///    - Size: 28.0
            ///    - Multiline alignment: center
            Text(String(localized: "Game Title"))
                .font(.custom("Chalkduster", size: 28.0))
                .multilineTextAlignment(.center)
                .frame(width: 230, height: 115)

            /// - versionLabel (width 150, height 20)
            ///    - Type: Text
            ///    - Text: "Version: 1.0"
            ///    - Font: headline
            ///    - Padding: ???
            ///    - Content: Pull from Bundle with code below and with helper code "buildNumber"
            /// ```Swift
            /// Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {}
            /// ```
            Text(String(localized: "Version") + ": " + version + "." + buildNumber)
                .font(.headline)
                .frame(width: 150, height: 20)

            /// - developersLabel (height 20)
            ///     - Type: Text
            ///     - Text: "Developers :"
            ///     - Font: bold
            ///     - Padding: horizontal, 40
            /// - Spacer
            HStack {
                Text(String(localized: "Developers :"))
                    .bold()
                    .frame(height: 20)
                    .padding(.horizontal, 40)

                Spacer()
            }

            /// - staffsLabel (width 260, height 90)
            ///    - Type: Text
            ///    - Text: "Team leader: Hungu Lim \n
            ///            Technical writer: Jisu Lim
            ///            Quality manager: Hyunsu Lim..."
            ///    - Font: semibold
            ///    - Multiline alignment: leading
            Text(String(localized: "Staffs"))
                .fontWeight(.semibold)
                .frame(width: 260, height: 90)
                .multilineTextAlignment(.leading)

            /// - licenseLabel (height 20)
            ///    - Type: Text
            ///    - Text: "License Info :"
            ///    - Font: bold
            ///    - Padding: horizontal, 40
            /// - Spacer
            HStack {
                Text(String(localized: "License Info :"))
                    .bold()
                    .frame(height: 20)
                    .padding(.horizontal, 40)

                Spacer()
            }

            /// - Scrollview (width 330, height 280)
            ///     - License info text
            ///         - Font: caption
            ///         - Multiline Text Alignment: leading
            ///         - Padding
            ScrollView {
                Text(String(localized: "License"))
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .padding()
            }
            .frame(width: 330, height: 280)



        }
    }
}

#Preview {
    AboutView()
}
