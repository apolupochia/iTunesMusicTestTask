//
//  CourseCellViewModel.swift
//  iTunesMusic
//
//  Created by Алёша Виноградов on 27.05.2023.
//

import Foundation

 
protocol CellIdentifiable {
    var cellIdentifier: String { get }
    var cellHeight: Double { get }
}

protocol SectionRowPresentable {
    var rows: [CellIdentifiable] { get set }
}

class SongCellViewModel: CellIdentifiable {
    let songName: String
    let authorName : String
    
    let imageStringURL: String
    
    var cellIdentifier: String {
        "songCell"
    }
    
    var cellHeight: Double {
        115
    }
    
    init(song: Result) {
        songName = song.trackName
        authorName = song.artistName
        if let urlStringImage = song.artworkUrl100{
            imageStringURL = urlStringImage
        } else {
            imageStringURL = ""
        }
       
    }
}

class SongSectionViewModel: SectionRowPresentable {
    var rows: [CellIdentifiable] = []
}

