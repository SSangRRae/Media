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
    let languageParam = "?language=ko-KR"
    
    func fetchTrendingTV(completionHandler: @escaping ([TV]) -> Void) {
        let url = baseURL + "trending/tv/week" + languageParam
        
        AF.request(url, headers: header).responseDecodable(of: TVModel.self) { response in
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
        let url = baseURL + "tv/top_rated" + languageParam
        
        AF.request(url, headers: header).responseDecodable(of: TVModel.self) { response in
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
        let url = baseURL + "tv/popular" + languageParam
        
        AF.request(url, headers: header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success)
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchInfoDrama(completionHandler: @escaping (DramaModel) -> Void) {
        let url = baseURL + "tv/96102" + languageParam
        
        AF.request(url, headers: header).responseDecodable(of: DramaModel.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success)
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchRecommendationDrama(completionHandler: @escaping ([TV]) -> Void) {
        let url = baseURL + "tv/96102/recommendations" + languageParam
        
        AF.request(url, headers: header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success)
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchAggregateCredits(completionHandler: @escaping ([Person]) -> Void) {
        let url = baseURL + "tv/96102/aggregate_credits" + languageParam
        
        AF.request(url, headers: header).responseDecodable(of: AggregateModel.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success)
                completionHandler(success.cast)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private init() {}
}
