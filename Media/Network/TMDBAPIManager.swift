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
    
    func fetchToTVSeries(api: TMDBAPI, completionHandler: @escaping ([TV]) -> Void) {
        AF.request(api.url,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success)
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchInfoDrama(api: TMDBAPI, completionHandler: @escaping (DramaModel) -> Void) {
        AF.request(api.url, headers: api.header).responseDecodable(of: DramaModel.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success)
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchAggregateCredits(api: TMDBAPI,completionHandler: @escaping ([Person]) -> Void) {
        AF.request(api.url, headers: api.header).responseDecodable(of: AggregateModel.self) { response in
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
