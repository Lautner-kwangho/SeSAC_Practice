//
//  Linked+extension.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/31.
//

import Foundation

extension LinkedVC {
    func callLinkedData(type: String, genreID: String) {
        MainAPIManager.shared.fetchContentApi(genre: type, genreID: genreID, type: "videos") { json in
            for item in json["results"].arrayValue {
                let videoType = item["type"].stringValue
                let key = item["key"].stringValue
                let data = LinkModel(name: videoType, key: key)
                
                self.linkData.append(data)
            }
            self.linkedTableView.reloadData()
            print(self.linkData)
        }
    }
   
}
