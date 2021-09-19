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

    private let player = Player.shared
    private(set) var playlist = SongStack<Song>(maxSize: 50)
    private(set) var index = 0
    var currentSong: Song? {
        return playlist.getElement(by: index)
    }
    var currentTime: Double {
        get {
            return player.currentTime
        }
        set {
            player.currentTime = newValue
        }
    }
    var duration: Double {
        return player.duration
    }

    private let dirURL = URL(fileURLWithPath: "/Users/daniil/Desktop/", isDirectory: true)

    private init() {
        player.onSongFinished = songFinished
    }
    

    // MARK: - Methods

    // Get the document directory url
    private let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    func getAllFilesFromFolder() -> [Song]? {
        var songs: [Song] = []
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: dirURL, includingPropertiesForKeys: nil)

            // Filter the directory contents to *.mp3 files only:
            let mp3FilesURLs = directoryContents.filter{ $0.pathExtension == "mp3" }

            for songURL in mp3FilesURLs {
                let songTitle = songURL.deletingPathExtension().lastPathComponent
                let song = Song(title: songTitle, url: songURL)
                songs.append(song)
            }
        } catch {
            print(error)
        }
        return songs.isEmpty ? nil : songs
    }

    func getPlaylist() -> SongStack<Song> {
        return playlist
    }

    func songFinished() {
    }

    func addToPlaylist(_ songs: [Song]) {
        for song in songs {
            playlist.push(song)
        }
    }

    func setCurrentSongIndex(_ index: Int) {
        self.index = index
    }

    func playPlaylist() {
        playSong()
    }

    // ?????????

    func playSong() {
        if player.getPlayerStatus() == .isReadyToPlay {
            player.play()
            return
        }
        player.prepareToPlay(currentSong!)
        playSong()
    }

    func play(atTime time: TimeInterval) {
        player.playAt(time)
    }

    func pauseSong() {
        player.pause()
    }

    func playNextSong() {
        player.stop()
        if currentSong != playlist.last() {
            let i = index + 1
            setCurrentSongIndex(i)
            player.prepareToPlay(playlist.getElement(by: i))
            playSong()
        } else {
            return
        }

    }

    func playPrevSong() {
        player.stop()
        if index != 0 {
            let i = index - 1
            setCurrentSongIndex(i)
            player.prepareToPlay(playlist.getElement(by: i))
            playSong()
        } else {
            return
        }

        
    }

}
