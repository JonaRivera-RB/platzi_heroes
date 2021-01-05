//
//  HeroesViewModel.swift
//  Platzi_heroes
//
//  Created by Jonathan Rivera Misael on 05/01/21.
//

import Foundation

class HeroesViewModel {
    
    var error: Observable<Bool?> = Observable(nil)
    var heroesResponse: Observable<HeroesModel?> = Observable(nil)
    
    func getHeroes(toPage page: String? = nil) {
        HeroesUseCase.request(toPage: page) { [weak self]  (heroes, error) in
            
            if let heroes = heroes {
                self?.heroesResponse.value = heroes
            }else {
                self?.error.value = true
            }
        }
    }
    
    var numberOfItemsInSections: Int {
        return heroesResponse.value?.data?.results?.count ?? 0
    }
    
    func getHeroe(indexPath: Int) -> HeroeList? {
        return heroesResponse.value?.data?.results?[indexPath]
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
