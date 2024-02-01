//
//  TMDBAPI.swift
//  Media
//
//  Created by SangRae Kim on 2/1/24.
//

import UIKit
import Alamofire

enum TMDBAPI {
    case trending
    case topRated
    case popular
    case recommendation(id: Int)
    case info(id: Int)
    case credit(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var url: String {
        switch self {
        case .trending: baseURL + "trending/tv/week"
        case .topRated: baseURL + "tv/top_rated"
        case .popular: baseURL + "tv/popular"
        case .recommendation(let id): baseURL + "tv/\(id)/recommendations"
        case .info(let id): baseURL + "tv/\(id)"
        case .credit(let id): baseURL + "tv/\(id)/aggregate_credits"
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.tmdb]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        return ["language": "ko-KR"]
    }
}
