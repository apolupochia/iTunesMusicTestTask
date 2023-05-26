//
//  PageWithAllSongsInteractor.swift
//  iTunes
//
//  Created by Алёша Виноградов on 26.05.2023.
//

import Foundation

protocol PageWithAllSongsInteractorInputProtocol{
    init(presentor : PageWithAllSongsInteractorOutputProtocol)
    func fetchSongsFromUrl(songName : String)
    
}

protocol PageWithAllSongsInteractorOutputProtocol : AnyObject{
    func updatedSongsModel(songs : MusicModel)
}

class PageWithAllSongsInteractor : PageWithAllSongsInteractorInputProtocol{


    
    unowned var presentor : PageWithAllSongsInteractorOutputProtocol
    
    required init(presentor: PageWithAllSongsInteractorOutputProtocol) {
        self.presentor = presentor
        
    }
   
    func fetchSongsFromUrl(songName: String) {
        NetworkDataFetch.shared.fetchMusics(songName: songName) {[weak self] model, error in
            if error == nil{
                guard let model = model else { return }
                
                self?.presentor.updatedSongsModel(songs: model)
                
            } else {
            //    print(error?.localizedDescription)
            }
        }
    }
    
}
