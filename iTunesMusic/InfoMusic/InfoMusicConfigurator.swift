//
//  InfoMusicConfigurator.swift
//  iTunes
//
//  Created by Алёша Виноградов on 26.05.2023.
//

import Foundation
import UIKit


protocol InfoSongConfiguratorInputProtocol{
    func configure(with viewController: InfoSongViewController, info : SongwithoutImage)
}

class InfoSongConfigurator : InfoSongConfiguratorInputProtocol{
    func configure(with viewController: InfoSongViewController, info : SongwithoutImage) {
        let presenter = InfoSongPresentor(viewController: viewController)
        let interactor = InfoSongInteractor(presentor: presenter,info: info)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
    }
    
    
}
