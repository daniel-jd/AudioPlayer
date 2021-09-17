//
//  Player.swift
//  AudioPlayer
//
//  Created by Daniel Yamrak on 17.09.2021.
//

//import Foundation
import AVFoundation
import AudioToolbox

final class Player {

    static let shared = Player()
    private var player: AVPlayer?
    private var status = PlayerStatus.failed
    var onSongFinished: (()->Void)?

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

    func test(test: String, handler: @escaping (()->Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            handler()
        }
    }

    func prepareToPlay(_ song: Song) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)

            player = AVPlayer(url: song.url)
            status = .isReadyToPlay

        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func play() {
        guard let player = player else { return }
        player.play()
    }

    func play(start second: Double) {
        guard let player = player else { return }
        player.seek(to: CMTimeMakeWithSeconds(second, preferredTimescale: 1000))
        player.play()
    }

    func pause() {
        player?.pause()
    }

    @objc func fileComplete() {
        onSongFinished?()
    }
}
