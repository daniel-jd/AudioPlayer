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
    @IBOutlet weak var timeFromStartLabel: UILabel! {
        didSet {
            timeFromStartLabel.text = "0:00"
        }
    }
    @IBOutlet weak var songDurationLabel: UILabel!
    @IBOutlet weak var songSlider: UISlider! {
        didSet {
            songSlider.setValue(0.00, animated: true)
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
    private var timer: Timer?

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
        songSlider.maximumValue = Float(pm.duration / 60)
        songDurationLabel.text = formatted(time: pm.duration)

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateLabel),
                                     userInfo: nil, repeats: true)

    }

    @objc func updateLabel() {
        songSlider.setValue(Float(pm.currentTime)/60, animated: true)
        timeFromStartLabel.text = formatted(time: pm.currentTime)
    }

    private func registerCollectionViewCell() {
        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
    }

    private func updateUILabelsWith(_ currentSong: Song) {
        songTitleLabel.text = "Almaz Worship"
        artistLabel.text = pm.currentSong?.title
        songDurationLabel.text = formatted(time: pm.duration)
        timeFromStartLabel.text = "0:00"
        songSlider.setValue(0.00, animated: true)
        songSlider.maximumValue = Float(pm.duration / 60)
    }

    private func formatted(time: Double) -> String {
        var seconds = Int(ceil(time))
        var hours = 0
        var mins = 0

        if seconds > 3600 {
            hours = seconds / 3600
            seconds -= hours * 3600
        }

        if seconds > 60 {
            mins = seconds / 60
            seconds -= mins * 60
        }

        var formattedString = ""
        if hours > 0 {
            formattedString = "\(String(format: "%02d", hours)):"
        }
        formattedString += "\(String(format: "%02d", mins)):\(String(format: "%02d", seconds))"
        return formattedString
    }

    @IBAction func menuButtonPressed(_ sender: Any) {
        timer?.invalidate()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if isPlaying {
            pm.pauseSong()
            songSlider.maximumValue = Float(pm.duration / 60)
        } else {
            pm.playSong()
            songSlider.maximumValue = Float(pm.duration / 60)
        }
        isPlaying = !isPlaying
    }

    @IBAction func forwardButtonPressed(_ sender: Any) {
        pm.playNextSong()
        guard let currentSong = pm.currentSong else { return }
        updateUILabelsWith(currentSong)
    }

    @IBAction func backwardButtonPressed(_ sender: Any) {
        pm.playPrevSong()
        guard let currentSong = pm.currentSong else { return }
        updateUILabelsWith(currentSong)
    }

    @IBAction func volumeSliderMoved(_ sender: Any) {
    }

    @IBAction func songDurationMoved(_ sender: Any) {
        pm.currentTime = Double(songSlider.value)
        pm.play(atTime: Double(songSlider.value))
    }
}

// MARK: - CollectionView Delegate & Data Source

extension APViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pm.playlist.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        return cell
    }


}
