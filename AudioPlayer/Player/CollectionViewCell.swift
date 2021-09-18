//
//  CollectionViewCell.swift
//  AudioPlayer
//
//  Created by Daniel Yamrak on 18.09.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        customizeCell()
    }

    func customizeCell() {
        imageView.layer.cornerRadius = 8.0
        imageView.image = #imageLiteral(resourceName: "photo_2021-09-18 20.47.56")
    }
}
