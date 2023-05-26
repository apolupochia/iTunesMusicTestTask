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

    
    func loadImg(image: UIImage, nameOfSong: String, nameOfAuthor: String){
        viewController.fetchImage(image: image, nameOfSong: nameOfSong, nameOfAuthor: nameOfAuthor)
        
    }
}
