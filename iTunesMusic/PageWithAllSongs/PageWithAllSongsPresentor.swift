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
    
    func tabOnSelectRow(song: SongCellViewModel) {
        
        let song = SongwithoutImage(songName: song.songName, urlImageString: song.imageStringURL, songAuthor: song.authorName)
        router.openInfoMusicViewController(song: song)
    }
    
    func fetchSongs(songName: String) {
        interactor.fetchSongsFromUrl(songName: songName)
    }
    
    func didTabCancelOrСhangeWord(section: SongSectionViewModel) {
        section.rows = []
        viewController.reloadDataAfterCancel()
    }

}

extension PageWithAllSongsPresentor : PageWithAllSongsInteractorOutputProtocol{
    func updatedSongsModel(songs: MusicModel) {
        
        let section = SongSectionViewModel()
        songs.results.forEach { section.rows.append(SongCellViewModel(song: $0)) }
        viewController.reloadData(for: section)
    //    viewController.updateSongsModel(songs: songs)
    }
    
}
