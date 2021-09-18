//
//  SongsListViewController.swift
//  AudioPlayer
//
//  Created by Daniel Yamrak on 17.09.2021.
//

import UIKit

class SongsListViewController: UIViewController {

    @IBOutlet weak var playerButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    private lazy var playerManager = PlayerManager.shared

    var songsList = [Song]()
    var selectedSongs = [Song]()


// MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        if let songs = playerManager.getAllFilesFromFolder() {
            print("Yeah! We have songs")
            songsList = songs
        } else {
            print("Oops, no songs were found")
        }
     
    }

// MARK: - METHODS

    func showPlayerVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let playerVC = storyboard.instantiateViewController(identifier: "APViewController") as! APViewController
        present(playerVC, animated: true, completion: nil)
    }

    func getSelectedSongs() {
        selectedSongs = []
        for song in songsList {
            if song.isSelected {
                selectedSongs.append(song)
            }
        }
    }

    func clearSongSelection() {
        for i in 0..<songsList.count {
            songsList[i].isSelected = false
        }
    }

// MARK: - IBActions

    @IBAction func playerButtonPressed(_ sender: Any) {
        getSelectedSongs()
        if !selectedSongs.isEmpty {
            playerManager.addToPlaylist(selectedSongs)
            showPlayerVC()
        } else {
            playerButton.setTitle("Select Songs First", for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.50) {
                self.playerButton.setTitle("PLAY", for: .normal)
            }
        }
    }

}


// MARK: - Delegate & Data Source

extension SongsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell")!
        cell.textLabel?.textColor = .white
        if songsList[indexPath.row].isSelected == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = songsList[indexPath.row].title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let i = indexPath.row
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            songsList[i].isSelected = true
        } else if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            songsList[i].isSelected = false
        }
    }
}
