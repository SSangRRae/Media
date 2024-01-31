//
//  TMDBAPIManager.swift
//  Media
//
//  Created by SangRae Kim on 1/31/24.
//

import UIKit
import Alamofire

class TMDBAPIManager {
    static let shared = TMDBAPIManager()
    
    let header: HTTPHeaders = ["Authorization": APIKey.tmdb]
    let baseURL = "https://api.themoviedb.org/3/"
    
    func fetchTrendingTV(completionHandler: @escaping ([TV]) -> Void) {
        let url = "trending/tv/week?language=ko-KR"
        
        AF.request(baseURL+url, headers: header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success)
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTopRatedTV(completionHandler: @escaping ([TV]) -> Void) {
        let url = "tv/top_rated?language=ko-KR"
        
        AF.request(baseURL+url, headers: header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success)
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchPopularTV(completionHandler: @escaping ([TV]) -> Void) {
        let url = "tv/popular?language=ko-KR"
        
        AF.request(baseURL+url, headers: header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success)
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private init() {}
}
