//
//  HeroeUseCase.swift
//  Platzi_heroes
//
//  Created by Jonathan Rivera Misael on 05/01/21.
//

import Foundation

struct HeroeUseCase {
    
    static let _getRequest = GetDataHttp()
    
    static func request(toId characherID: String, completion: @escaping(_ heroes: HeroeDetailModel?, _ error: Bool?) -> () ) {
        var urlComponets = URLComponents(string: Routes.URLMARVEL + Routes.characters + "/" + characherID)
        urlComponets?.queryItems = [
            URLQueryItem(name: "apikey", value: "d329be63b9ebccebaf007906bc33ea8d"),
            URLQueryItem(name: "hash", value: "45915367939993da005ee5e59068c3b4"),
            URLQueryItem(name: "ts", value: "1"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "limit", value: "10")
        ]
        
        _getRequest.url = urlComponets?.url
        _getRequest.header = false
        _getRequest.forData { (data, error, success) in
            if let data = data, let heroe = DataFetcher<HeroeDetailModel>().getData(data: data) {
                completion(heroe, nil)
                return
            }else {
                completion(nil, false)
                return
            }
        }
    }
}
