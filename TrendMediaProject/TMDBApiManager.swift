//
//  TMDBApiManager.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/28.
//

import Foundation
import SwiftyJSON
import Alamofire

struct TMDBApiManager {
    static let shared = TMDBApiManager()
    
    func fetchData(page: Int, result: @escaping (JSON) -> ()) {
        
        let url = Endpoint.tmdbURL + APIkey.tmdbKEY + "&query=&page=\(page)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                result(json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
