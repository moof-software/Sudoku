//
//  AudioManager.swift
//  Sudoku
//
//  Created by Hungu Lim on 9/27/25.
//

import AVKit
import Foundation

/// Class for managing sound throughout the game.
///
/// - Parameters:
///     - instance: static constant that takes in its class (singleton pattern)
///     - effectPlayer: variable with AVAudioPlayer optional type.
///     - backgroundPlayer: variable with AVAudioPlayer optional type.
///
/// - Methods:
///     - `playEffect`
///         - Function: Brings in an effct sound from Bundle URL and inputs into `effectPlayer`. Plays effect immediately,
///     - `prepareBGSound`
///         - Function: Brings in a background soundf from Bundle URL and inputs into `AVAudioPlayer`. Sets loop to -1
///     - `playBGSound`
///         - Function: Plays background sound.
///     - `playEffect`
///         - Function: Stops background sound.
class AudioManager {
    static let instance = AudioManager() // singleton

    var effectPlayer: AVAudioPlayer?
    var backgroundPlayer: AVAudioPlayer?

    /// Function for bringing in an effect sound from Bundle and playing it immediately,
    /// - Logic:
    ///     - Bring in an effect sound "stamp" for Bundle as an url with guard statement.
    ///     - if url exists, do the action of playing the sound. Else, catch error.
    func playEffect() {
        guard
            let url = Bundle.main.url(
                forResource: "stamp",
                withExtension: "mp3"
            )
        else {
            return
        }

        do {
            effectPlayer = try AVAudioPlayer(contentsOf: url)
            effectPlayer?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }

    /// Function for bringing in a background sound from Bundle and setting up loops.,
    /// - Logic:
    ///     - Bring in a background sound "Appalachian Dance" from Bundle as an url with guard statement.
    ///     - if url exists, do the action of setting `AVAudioPlayer`. Else, catch error.
    func prepareBGSound() {
        guard
            let url = Bundle.main.url(
                forResource: "Appalachian Dance",
                withExtension: "mp3"
            )
        else {
            return
        }

        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }

    /// Function for playing background sound.
    /// - Logic:
    ///     - Call play on `backgroundPlayer`.
    func playBGsound() {
        backgroundPlayer?.play()
    }

    /// Function for stopping background sound.
    /// - Logic:
    ///     - Call stop on `backgroundPlayer`.
    func stopBGsound() {
        backgroundPlayer?.stop()
    }
}
