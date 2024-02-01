//
//  AggregateModel.swift
//  Media
//
//  Created by SangRae Kim on 2/1/24.
//

import UIKit

struct AggregateModel: Decodable {
    let id: Int
    let cast: [Person]
}

struct Person: Decodable {
    let id: Int
    let name: String
    let profile: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profile = "profile_path"
    }
}
