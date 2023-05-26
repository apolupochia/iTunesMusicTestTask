//
//  NetworkRequest.swift
//  iTunes
//
//  Created by Алёша Виноградов on 26.05.2023.
//

import Foundation

class NetworkRequest{
    static let shared = NetworkRequest()

    func requestData(songName : String, complition: @escaping(Data?, Error?) -> Void){
        guard var urlCompanents = URLComponents(string: "https://itunes.apple.com/search") else {return}
        urlCompanents.queryItems = [
        
            URLQueryItem(name: "term", value: songName),
            URLQueryItem(name: "entity", value: "musicTrack"),
        ]
        
        guard let url = urlCompanents.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error{
                    print(error.localizedDescription)
                    complition( nil, error)
                    return
                }
                guard let data = data else {return}
                complition(data,nil)
                
            }
        }.resume()
        
    }
    
    func requestImageData(urlString : String, complition: @escaping(Data?, Error?) -> Void){
        guard let url = URL(string: urlString) else {return}

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error{
                    print(error.localizedDescription)
                    complition( nil, error)
                    return
                }
                guard let data = data else {return}
                complition(data,nil)
                
            }
        }.resume()
        
    }
}
