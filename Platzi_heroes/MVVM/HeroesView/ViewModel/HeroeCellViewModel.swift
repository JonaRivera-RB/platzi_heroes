//
//  HeroeCellViewModel.swift
//  Platzi_heroes
//
//  Created by Jonathan Rivera Misael on 05/01/21.
//

import Foundation

struct HeroeCellViewModel {
    var heroeList: HeroeList
    
    init(heroeList: HeroeList) {
        self.heroeList = heroeList
    }
    
    var heroeImageURL: URL {
        let thumbnail = heroeList.thumbnail?.path ?? ""
        let thumbnailExtension = heroeList.thumbnail?.thumbnailExtension?.rawValue ?? ""
        
        return URL(string: thumbnail+"/"+AppConstans.VARIANT_NAME+"."+thumbnailExtension)!
    }
    
    var heroeName: String {
        return heroeList.name ?? ""
    }
}
