//
//  HeroesUseCase.swift
//  Platzi_heroes
//
//  Created by Jonathan Rivera Misael on 05/01/21.
//

import Foundation

struct HeroesUseCase {
    
    static let _getRequest = GetDataHttp()
    
    static func request(toPage page: String?, completion: @escaping(_ heroes: HeroesModel?, _ error: Bool?) -> () ) {
        var urlComponets = URLComponents(string: Routes.URLMARVEL + Routes.characters)
        urlComponets?.queryItems = [
            URLQueryItem(name: "apikey", value: "d329be63b9ebccebaf007906bc33ea8d"),
            URLQueryItem(name: "hash", value: "45915367939993da005ee5e59068c3b4"),
            URLQueryItem(name: "ts", value: "1"),
            URLQueryItem(name: "offset", value: page ?? "0"),
            URLQueryItem(name: "limit", value: "10")
        ]
        
        _getRequest.url = urlComponets?.url
        _getRequest.header = false
        _getRequest.forData { (data, error, success) in
            if let data = data, let heroes = DataFetcher<HeroesModel>().getData(data: data) {
                completion(heroes, nil)
                return
            }else {
                completion(nil, false)
                return
            }
        }
    }
}
