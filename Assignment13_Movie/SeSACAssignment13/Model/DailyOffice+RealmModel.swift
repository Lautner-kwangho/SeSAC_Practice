//
//  RealmModel.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/11/02.
//

import Foundation
import RealmSwift

class RealmModel: Object {
    @Persisted var rank : Int
    @Persisted var movieNm : String
    @Persisted var openDt : String
    @Persisted var showRange: String
    @Persisted(primaryKey: true) var _id: ObjectId
    // JSON 스키마 있던데..
    convenience init(rank: Int, movieNm: String, openDt: String, showRange: String) {
        self.init()
        self.rank = rank
        self.movieNm = movieNm
        self.openDt = openDt
        self.showRange = showRange
    }
    
}
