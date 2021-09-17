//
//  PlayerManager.swift
//  AudioPlayer
//
//  Created by Daniel Yamrak on 17.09.2021.
//

import Foundation
import AVFoundation
import AudioToolbox

class PlayerManager {

    static let shared = PlayerManager()
    private var playList = [NSURL]()
    private var player: AVPlayer?

    private init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fileComplete),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil
        )
    }

// MARK: Player API
    func addToQueue(with url: URL) {

    }

    func playFile(withFile url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            player = AVPlayer(url: url)

            guard let player = player else { return }
            player.play()

        } catch {
            print(error.localizedDescription)
        }
    }

    @objc func fileComplete() {
    }
}
