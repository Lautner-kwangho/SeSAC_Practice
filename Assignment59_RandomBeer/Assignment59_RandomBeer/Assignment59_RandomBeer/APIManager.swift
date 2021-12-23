//
//  APIManager.swift
//  Assignment59_RandomBeer
//
//  Created by 최광호 on 2021/12/21.
//

import Foundation
import Alamofire

struct APIManager: Decodable {
    
    static let shared = APIManager()
    
    func beerAPI(completion: @escaping ([Beer]) -> Void) {
        let url = "https://api.punkapi.com/v2/beers/random"
        let decoder = JSONDecoder()
        // 아 [] 이거 해줬어야 했네 그리고 너무 많으니까 확인하는데 눈 아파서 부분만 받아옴
        AF.request(url).responseDecodable(of: [Beer].self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let AFError):
                print(AFError)
            }
        }
    }
}
