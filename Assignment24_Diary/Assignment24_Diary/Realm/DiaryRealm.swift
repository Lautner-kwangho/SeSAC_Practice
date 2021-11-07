//
//  DiaryRealm.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/07.
//

import Foundation
import RealmSwift

class DiaryRealm: Object {
    @Persisted var diaryTitle: String
    @Persisted var diaryContent: String?
    @Persisted var diaryDate: String
    @Persisted var diaryRegister = Date()
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(diaryTitle: String, diaryContent: String?, diaryDate: String, diaryRegister: Date) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContent
        self.diaryDate = diaryDate
        self.diaryRegister = diaryRegister
    }
}
