//
//  DetailHeroViewModel.swift
//  Platzi_heroes
//
//  Created by Jonathan Rivera Misael on 05/01/21.
//

import Foundation

class DetailHeroViewModel {
    
    var error: Observable<Bool?> = Observable(nil)
    var heroeResponse: Observable<HeroeDetailModel?> = Observable(nil)
    
    func getHeroe(heroeID: Int) {
        HeroeUseCase.request(toId: String(heroeID)) { [weak self]  (heroe, error) in
            
            if let heroe = heroe {
                self?.heroeResponse.value = heroe
            }else {
                self?.error.value = true
            }
        }
    }
    
    var heroeName: String {
        return heroeResponse.value?.data?.results?[0].name ?? ""
    }
    
    var description: String {
        let description = heroeResponse.value?.data?.results?[0].description ?? ""
        return  description == "" ? "Sin descripción" : description
    }
    
    var urlImage: URL {
        let thumbnail = heroeResponse.value?.data?.results?[0].thumbnail?.path ?? ""
        let thumbnailExtension = heroeResponse.value?.data?.results?[0].thumbnail?.thumbnailExtension?.rawValue ?? ""
            
        return URL(string: thumbnail+"/landscape_xlarge."+thumbnailExtension)!
    }
    
    var numberOfComics: Int {
        return heroeResponse.value?.data?.results?[0].comics?.items?.count ?? 0
    }
    
    func getComicItem(indexPath: Int) -> ComicsItem? {
        return heroeResponse.value?.data?.results?[0].comics?.items?[indexPath]
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
