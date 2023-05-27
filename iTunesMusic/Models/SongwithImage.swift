//
//  SongwithImage.swift
//  iTunesMusic
//
//  Created by Алёша Виноградов on 27.05.2023.
//

import Foundation
import UIKit


struct SongwithImage {
    let songName: String
    let downloadingImage : Bool
    let image: UIImage
    let songAuthor: String
}

struct SongwithoutImage {
    let songName: String
    let urlImageString : String
    let songAuthor: String
}
