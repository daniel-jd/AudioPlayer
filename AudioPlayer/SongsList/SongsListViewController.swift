//
//  SongsListViewController.swift
//  AudioPlayer
//
//  Created by Daniel Yamrak on 17.09.2021.
//

import UIKit

class SongsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let songsList = [
        Bundle.main.url(forResource: "Бог кличе", withExtension: "mp3")!,
        Bundle.main.url(forResource: "Вірим ми", withExtension: "mp3")!,
        Bundle.main.url(forResource: "Мій шлях", withExtension: "mp3")!,
        Bundle.main.url(forResource: "Любовь Твоя верна", withExtension: "mp3")!,
        Bundle.main.url(forResource: "Ти благий", withExtension: "mp3")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
     
    }

    @IBAction func playerButtonPressed(_ sender: Any) {

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
        cell.textLabel?.text = songsList[indexPath.row].description
        return cell
    }


}
