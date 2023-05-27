//
//  InfoMusicPresentor.swift
//  iTunes
//
//  Created by Алёша Виноградов on 26.05.2023.
//

import Foundation
import UIKit

class InfoSongPresentor : InfoSongViewControllerOutputProtocol{

    unowned var viewController : InfoSongViewControllerInputProtocol
    var interactor : InfoSongInteractorInputPresentor!
    
    var startOrPauseBitton = false
    
    required init(viewController: InfoSongViewControllerInputProtocol) {
        self.viewController = viewController
    }
    
    func loadInfoAboutView() {
        interactor.getInfoAboutView()
    }
    
    func tabStartOrPause() {
        startOrPauseBitton.toggle()
        viewController.changeImagestartSongButton(playNow: startOrPauseBitton)
        
    }
    
    
}

extension InfoSongPresentor :  InfoSongInteractorOutputPresentor{

    
    func loadImg(image: UIImage, downloadingImage : Bool, nameOfSong: String, nameOfAuthor: String){
        let song = SongwithImage(songName: nameOfSong, downloadingImage: false, image: image, songAuthor: nameOfAuthor)
        if !downloadingImage{
            viewController.fetchInfoWithImageImage(song: song)
        } else {
            viewController.fetchInfoWithoutImageImage(song: song)
        }
        
    }
}
