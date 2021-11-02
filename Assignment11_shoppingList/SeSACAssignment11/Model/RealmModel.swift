//
//  RealmModel.swift
//  SeSACAssignment11
//
//  Created by 최광호 on 2021/11/02.
//

import RealmSwift

class RealmModel: Object {
    @Persisted var name: String
    @Persisted var selectMark: Bool
    @Persisted var selectStar: Bool
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(name: String, selectMark: Bool, selectStar: Bool) {
        self.init()
        self.name = name
        self.selectMark = selectMark
        self.selectStar = selectStar
    }

}
