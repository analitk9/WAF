//
//  Element.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import Foundation



struct SearchElement: Codable {
    let total: Int
    let totalPages: Int
    let results: [Element]
    enum CodingKeys: String, CodingKey {
        case total = "total"
        case totalPages = "total_pages"
        case results = "results"
    }
}

struct Element: Codable {
    let id: String
    let createdAt: String
    let blurHash: String
    let urls: Urls
    let likes: Int
    let user: User
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case blurHash = "blur_hash"
        case createdAt = "created_at"
        case likes = "likes"
        case urls = "urls"
        case user = "user"
    }
}

struct Urls: Codable {
    let regular: URL
}


struct User: Codable {
    let name: String
}

struct ElementDetail: Codable {
    let id: String
    let location: Location
    let user: User
    let blurHash: String
    let downloads: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case location = "location"
        case user = "user"
        case blurHash = "blur_hash"
        case downloads = "downloads"
        case createdAt = "created_at"
    }
}

struct Location: Codable  {
    let city: String?
    let country: String?
    let position: Position
    
}

struct Position: Codable  {
    let latitude: Double?
    let longitude: Double?
}
