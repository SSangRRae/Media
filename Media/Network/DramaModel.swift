//
//  DramaModel.swift
//  Media
//
//  Created by SangRae Kim on 2/1/24.
//

import UIKit

struct DramaModel: Decodable {
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
