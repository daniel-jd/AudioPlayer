//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Daniel Yamrak on 17.09.2021.
//

import UIKit

class APViewController: UIViewController {

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var timeFromStartLabel: UILabel!
    @IBOutlet weak var songDurationLabel: UILabel!
    @IBOutlet weak var songSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!

    private var player: PlayerManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        player = PlayerManager.shared
    }


    @IBAction func menuButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
    }

    @IBAction func forwardButtonPressed(_ sender: Any) {
    }

    @IBAction func backwardButtonPressed(_ sender: Any) {
    }

    @IBAction func volumeSliderMoved(_ sender: Any) {
    }

    @IBAction func songDurationMoved(_ sender: Any) {
    }
}

