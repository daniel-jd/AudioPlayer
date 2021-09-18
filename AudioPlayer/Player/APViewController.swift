//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Daniel Yamrak on 17.09.2021.
//

import UIKit

class APViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var timeFromStartLabel: UILabel!
    @IBOutlet weak var songDurationLabel: UILabel!
    @IBOutlet weak var songSlider: UISlider! {
        didSet {
            songSlider.setValue(0.0, animated: true)
        }
    }
    @IBOutlet weak var volumeSlider: UISlider! {
        didSet {
            volumeSlider.setValue(90.0, animated: true)
        }
    }
    @IBOutlet weak var playPauseButton: UIButton!
    
    let nib = UINib(nibName: "CollectionViewCell", bundle: nil)

    private let pm = PlayerManager.shared

    private var isPlaying = false {
        didSet {
            switch isPlaying {
            case true:
                playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            case false:
                playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        collectionView.delegate = self
//        collectionView.dataSource = self

        registerCollectionViewCell()
        songTitleLabel.text = "Almaz Worship"
        artistLabel.text = pm.currentSong?.title
        pm.playPlaylist()
        isPlaying = true
        songDurationLabel.text = "\(String(format: "%.2f", pm.duration / 60))"

    }

    private func registerCollectionViewCell() {
        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
    }

    @IBAction func menuButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if isPlaying {
            pm.pauseSong()
        } else {
            pm.playSong()
        }
        isPlaying = !isPlaying
    }

    @IBAction func forwardButtonPressed(_ sender: Any) {
        pm.playNextSong()
    }

    @IBAction func backwardButtonPressed(_ sender: Any) {
        pm.playPrevSong()
    }

    @IBAction func volumeSliderMoved(_ sender: Any) {

    }

    @IBAction func songDurationMoved(_ sender: Any) {

    }
}

// MARK: - CollectionView Delegate & Data Source

extension APViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1//pm.playlist.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        return cell
    }


}
