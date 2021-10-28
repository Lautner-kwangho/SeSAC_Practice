//
//  MainAPIManager.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/28.
//

import Foundation
import Alamofire
import SwiftyJSON

class MainAPIManager {
    static let shared = MainAPIManager()
    
    func fetchMainApi(frontURL: String,pageCount: Int, result: @escaping (JSON) -> ()) {
        let url = "\(frontURL)?api_key=\(APIKEY.tvDB)&query=&page=\(pageCount)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                result(json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
