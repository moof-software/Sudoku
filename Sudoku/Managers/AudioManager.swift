//
//  AudioManager.swift
//  Sudoku
//
//  Created by Hungu Lim on 9/27/25.
//

import AVKit
import Foundation

class AudioManager {
    static let instnace = AudioManager()

    var effectPlayer: AVAudioPlayer?
    var backgroundPlayer: AVAudioPlayer?

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

    func playBGsound() {
        backgroundPlayer?.play()
    }

    func stopBGsound() {
        backgroundPlayer?.stop()
    }
}
