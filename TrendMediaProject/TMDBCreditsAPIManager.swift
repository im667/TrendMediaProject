//
//  TMDBCreditsAPIManager.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/29.
//

import Foundation
import Alamofire
import SwiftyJSON


class TMDBCreditsAPImanager {
    
    static let shared = TMDBCreditsAPImanager()
    
    func fetchTrendMediaCreditsData(movie_id: Int, result: @escaping (JSON) -> ()) {
            
        let url = Endpoint.tmdbGetCredit + "\(movie_id)" + "/credits?" + "api_key=\(APIkey.tmdbKEY)" + "&language=en-US"

            
            AF.request(url, method: .get).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json =  JSON(value)
                    print("JSON: \(json)")
                    result(json)
                
                case .failure(let error):
                    print("error: \(error)")
                
                }
            }
            
        }
    
    
}
