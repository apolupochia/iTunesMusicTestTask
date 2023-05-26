//
//  PageWithAllSongsConfigurator.swift
//  iTunes
//
//  Created by Алёша Виноградов on 26.05.2023.
//

import Foundation

protocol PageWithAllSongsConfiguratorInputProtocol{
    func configur(with viewController : PageWithAllSongsViewController)
}


class PageWithAllSongsConfigurator : PageWithAllSongsConfiguratorInputProtocol{
    func configur(with viewController: PageWithAllSongsViewController) {
        let presentor = PageWithAllSongsPresentor(viewController: viewController)
        let ineractor = PageWithAllSongsInteractor(presentor: presentor)
        let router = PageWithAllSongsRouter(viewController: viewController)
        
        viewController.presentor = presentor
        presentor.interactor = ineractor
        presentor.router = router
        
    }
    
    

    
    
}

