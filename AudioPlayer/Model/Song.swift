//
//  Song.swift
//  AudioPlayer
//
//  Created by Daniel Yamrak on 17.09.2021.
//

import Foundation

struct Song: Equatable {
    let title: String
    let url: URL
    var isSelected: Bool = false
}
