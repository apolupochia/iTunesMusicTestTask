//
//  PageWithAllSongsRouter.swift
//  iTunes
//
//  Created by Алёша Виноградов on 26.05.2023.
//

import Foundation

protocol PageWithAllSongsInputProtocol {
    init(viewController: PageWithAllSongsViewController)
    func openInfoMusicViewController(song: Result)
}

class PageWithAllSongsRouter : PageWithAllSongsInputProtocol{

    unowned var viewController : PageWithAllSongsViewController
    
    required init(viewController: PageWithAllSongsViewController) {
        self.viewController = viewController
    }
    
    func openInfoMusicViewController(song: Result) {
        let infoInRepositoryViewController =  InfoSongViewController()
        infoInRepositoryViewController.modalPresentationStyle = .fullScreen
        let configurator: InfoSongConfiguratorInputProtocol = InfoSongConfigurator()
        configurator.configure(with: infoInRepositoryViewController,info: song)
        viewController.navigationController?.pushViewController(infoInRepositoryViewController, animated: false)
    }
    
    
}
