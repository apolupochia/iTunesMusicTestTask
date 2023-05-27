//
//  InfoMusicInteractor.swift
//  iTunes
//
//  Created by Алёша Виноградов on 26.05.2023.
//

import Foundation
import UIKit

protocol InfoSongInteractorInputPresentor{
    init(presentor :  InfoSongInteractorOutputPresentor, info : SongwithoutImage)
    func getInfoAboutView()
}

protocol InfoSongInteractorOutputPresentor : AnyObject{
    func loadImg(image: UIImage, downloadingImage : Bool, nameOfSong: String, nameOfAuthor: String)
}

class InfoSongInteractor : InfoSongInteractorInputPresentor{
    
    unowned var presenter : InfoSongInteractorOutputPresentor
    var info : SongwithoutImage
    
    required init(presentor: InfoSongInteractorOutputPresentor, info : SongwithoutImage) {
        self.info = info
        self.presenter = presentor
    }
    
    func getInfoAboutView() {
        self.presenter.loadImg(image : downloadProblem!, downloadingImage: true , nameOfSong: self.info.songName, nameOfAuthor: self.info.songAuthor)
            NetworkDataFetch.shared.fetchImg(urlImage: info.urlImageString) { image in
                guard let img = image else {
                    self.presenter.loadImg(image : downloadProblem!, downloadingImage: false , nameOfSong: self.info.songName, nameOfAuthor: self.info.songAuthor)
                    return
                }
                self.presenter.loadImg(image: img, downloadingImage: false, nameOfSong: self.info.songName, nameOfAuthor: self.info.songAuthor)
                }
        
    }
    
    
}
