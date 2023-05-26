//
//  NetworkDataFetch.swift
//  iTunes
//
//  Created by Алёша Виноградов on 26.05.2023.
//

import Foundation
import UIKit


class NetworkDataFetch{
    static let shared = NetworkDataFetch()
    
    
    func fetchMusics(songName : String, responce : @escaping(MusicModel?, Error?) -> Void){
        
        NetworkRequest.shared.requestData(songName: songName) { data, error in
            guard let data = data else  {responce(nil, error); return}
            
            do{
                let music = try JSONDecoder().decode(MusicModel.self, from: data)
                responce(music, nil)
            } catch let jsonError {
                print("failed decode Json, error : \(jsonError.localizedDescription)")
                
            }
            
        }
        
    }
    func fetchImg(urlImage : String, responce : @escaping(UIImage?) -> Void){
        
        NetworkRequest.shared.requestImageData(urlString: urlImage) { data, error in
            guard let data = data else  {
                responce(nil)
                return
            }
            let image =  UIImage(data: data)
            responce(image)
        }
        
    }
}
