//
//  TrendingModel.swift
//  Media
//
//  Created by SangRae Kim on 1/31/24.
//

import Foundation

struct TVModel: Decodable {
    let page: Int
    let results: [TV]
}

struct TV: Decodable {
    let id: Int
    let name: String
    let overview: String
    let backdrop: String?
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case backdrop = "backdrop_path"
        case poster = "poster_path"
    }
}
