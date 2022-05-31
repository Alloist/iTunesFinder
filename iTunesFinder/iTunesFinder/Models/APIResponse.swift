//
//  APIResponse.swift
//  iTunesFinder
//
//  Created by Aliaksei Gorodji on 27.05.22.
//

import Foundation

struct APIResponse: Decodable {
    let resultCount: Int
    let results: [Item]
}

struct Item: Decodable {
    
    let artistId: Int
    let artistName: String
    let artistViewUrl: String?
    let artworkUrl60, artworkUrl100: String
    let releaseDate: String
    let wrapperType: WrapperType?
    
    let trackName: String?
    let primaryGenreName: String?
    let description: String?
  
}

enum Country: String, Decodable {
    case usa = "USA"
}

enum Currency: String, Decodable {
    case usd = "USD"
}

enum WrapperType: String, Decodable {
    case software = "software"
    case track = "track"
    case ebook = "ebook"
}
