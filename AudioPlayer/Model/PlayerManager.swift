//
//  PlayerManager.swift
//  AudioPlayer
//
//  Created by Daniel Yamrak on 17.09.2021.
//

import Foundation
//import AVFoundation
//import AudioToolbox

class PlayerManager {

    static let shared = PlayerManager()
    private let player = Player.shared
    private var playlist = SongStack<Song>(maxSize: 5)
    var index = 0
    private var currentSong: Song? {
        return playlist.getElement(by: index)
    }

    private init() {
        player.onSongFinished = songFinished
    }

// MARK: - Methods

    func songFinished() {

    }

    func addToPlaylist(songs: [Song]) {
        songs.forEach { (song) in
            playlist.push(song)
        }
    }

    func setCurrentSong(_ index: Int) {
        self.index = index
    }

    func playSong() {
        if player.getPlayerStatus() == .isReadyToPlay {
            player.play()
            return
        }
        player.prepareToPlay(currentSong!)
        playSong()
    }

    func pauseSong() {
        player.pause()
    }

}
