//
//  HeroesViewModel.swift
//  Platzi_heroes
//
//  Created by Jonathan Rivera Misael on 05/01/21.
//

import Foundation

class HeroesViewModel {
    
    var error: Observable<Bool?> = Observable(nil)
    var heroesResponse: Observable<[HeroeList]?> = Observable(nil)
    private var heroes = [HeroeList]()
    var page: Int = 1
    
    func getHeroes() {
        HeroesUseCase.request(toPage: String(page)) { [weak self]  (heroes, error) in
            
            if let heroes = heroes {
                self?.heroes += heroes.data?.results ?? []
                self?.heroesResponse.value = self?.heroes
            }else {
                self?.error.value = true
            }
        }
    }
    
    var numberOfItemsInSections: Int {
        return heroesResponse.value?.count ?? 0
    }
    
    func getHeroeID(indexPath: Int) -> Int {
        return heroesResponse.value?[indexPath].id ?? 0
    }
    
    func getHeroe(indexPath: Int) -> HeroeList? {
        return heroesResponse.value?[indexPath]
    }
    
    func nextPage() {
        self.page = self.page + 10
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
