//
//  HeroesModel.swift
//  Platzi_heroes
//
//  Created by Jonathan Rivera Misael on 05/01/21.
//

import Foundation

struct HeroesModel: Codable {
    var code: Int?
    var data: DataResponse?
}

// MARK: - DataResponse
struct DataResponse: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [HeroeList]?
}

// MARK: - Result
struct HeroeList: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: Thumbnail?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    var path: String?
    var thumbnailExtension: Extension?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}
