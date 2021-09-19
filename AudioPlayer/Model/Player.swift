//
//  Player.swift
//  AudioPlayer
//
//  Created by Daniel Yamrak on 17.09.2021.
//

import Foundation
import AVFoundation
import AudioToolbox

final class Player {

    static let shared = Player()

    private var player: AVAudioPlayer?
    private var status = PlayerStatus.failed
    var onSongFinished: (()->Void)?
    var currentTime: Double {
        get {
            guard let player = player else { return 0.0 }
            return player.currentTime
        }
        set {
            guard let player = player else { return }
            player.currentTime = newValue
        }
    }
    var duration: Double {
        return player?.duration ?? 0.0
    }

    enum PlayerStatus {
        case isReadyToPlay
        case failed
    }

    private init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fileComplete),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil
        )
    }

// MARK: Player API
    func getPlayerStatus() -> PlayerStatus {
        return status
    }

    func prepareToPlay(_ song: Song) {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            do {
            player = try AVAudioPlayer(contentsOf: song.url)
            } catch {
                fatalError("Error creating player instance \(error.localizedDescription)")
            }
            status = .isReadyToPlay

        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func play() {
        guard let player = player else { return }
        player.play()
    }

    func playAt(_ time: TimeInterval) {
        guard let player = player else { return }
        player.play(atTime: time)
    }

    func stop() {
        guard let player = player else { return }
        player.stop()
    }

//    func play(start second: Double) {
//        guard let player = player else { return }
//        player.seek(to: CMTimeMakeWithSeconds(second, preferredTimescale: 1000))
//        player.play()
//    }

    func pause() {
        guard let player = player else { return }
        player.pause()
    }

    @objc func fileComplete() {
        onSongFinished?()
    }
}
