//
//  InfoMusicInteractor.swift
//  iTunes
//
//  Created by Алёша Виноградов on 26.05.2023.
//

import Foundation
import UIKit

protocol InfoSongInteractorInputPresentor{
    init(presentor :  InfoSongInteractorOutputPresentor, info : Result)
    func getInfoAboutView()
}

protocol InfoSongInteractorOutputPresentor : AnyObject{
    func loadImg(image : UIImage, nameOfSong: String, nameOfAuthor : String)
}

class InfoSongInteractor : InfoSongInteractorInputPresentor{
    
    unowned var presenter : InfoSongInteractorOutputPresentor
    var info : Result
    
    required init(presentor: InfoSongInteractorOutputPresentor, info : Result) {
        self.info = info
        self.presenter = presentor
    }
    
    func getInfoAboutView() {
        if let urlImg = info.artworkUrl100{
            NetworkDataFetch.shared.fetchImg(urlImage: urlImg) { image in
                guard let img = image else { return }
                DispatchQueue.main.async {
                    self.presenter.loadImg(image: img, nameOfSong: self.info.trackName, nameOfAuthor: self.info.artistName)
                }
            }
        }
    }
    
    
}
