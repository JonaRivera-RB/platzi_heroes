//
//  HeroeDetailModel.swift
//  Platzi_heroes
//
//  Created by Jonathan Rivera Misael on 05/01/21.
//

import Foundation

// MARK: - Welcome
struct HeroeDetailModel: Codable {
    var attributionText: String?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    var results: [HeroeResult]?
}

// MARK: - Result
struct HeroeResult: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: Thumbnail?
    var comics: Comics?
}

// MARK: - Comics
struct Comics: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [ComicsItem]?
    var returned: Int?
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    var resourceURI: String?
    var name: String?
}
