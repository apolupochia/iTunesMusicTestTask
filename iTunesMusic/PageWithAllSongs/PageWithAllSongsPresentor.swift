//
//  PageWithAllSongsPresentor.swift
//  iTunes
//
//  Created by Алёша Виноградов on 26.05.2023.
//

import Foundation


class PageWithAllSongsPresentor : PageWithAllSongsViewControllerOutputProtocol{

    

    
    unowned var viewController : PageWithAllSongsViewControllerInputProtocol
    var interactor : PageWithAllSongsInteractorInputProtocol!
    var router : PageWithAllSongsInputProtocol!
    
    
    required init(viewController: PageWithAllSongsViewControllerInputProtocol) {
        self.viewController = viewController
    }
    
    func tabOnSelectRow(song: Result) {
        router.openInfoMusicViewController(song: song)
    }
    
    func fetchSongs(songName: String) {
        interactor.fetchSongsFromUrl(songName: songName)
    }    

}

extension PageWithAllSongsPresentor : PageWithAllSongsInteractorOutputProtocol{
    func updatedSongsModel(songs: MusicModel) {
        viewController.updateSongsModel(songs: songs)
    }
    
}
