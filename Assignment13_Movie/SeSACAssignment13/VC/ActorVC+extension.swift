//
//  ActorVC+extension.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/31.
//

import Foundation

import Alamofire
import SwiftyJSON

extension ActorVC {
    
    func callCreditData(genre: String ,ID: String) {
        MainAPIManager.shared.fetchContentApi(genre: genre, genreID: ID, type: "credits") { json in
            
            for item in json["cast"].arrayValue {
                let profile = item["profile_path"].stringValue
                let name = item["name"].stringValue
                let character = item["character"].stringValue
                let data = ActorModel(profile_path: profile, name: name, character: character)
                
                self.actorData.append(data)
            }
            self.ActorTableView.reloadData()
            print(self.actorData)
        }
    }
}
