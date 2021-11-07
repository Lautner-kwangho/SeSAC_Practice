//
//  RealmQuery.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/07.
//

import UIKit
import RealmSwift

extension UIViewController {
    
    func searchQueryFromUserDiary(text: String) -> Results<DiaryRealm> {
        let localRealm = try! Realm()
        let search = localRealm.objects(DiaryRealm.self).filter("diaryTitle CONTAINS'\(text)' OR diaryContent CONTAINS[c] '\(text)'")
        return search
    }
    
    func getAllDiaryCountFromUserDiary() -> Int {
        let localRealm = try! Realm()
        return localRealm.objects(DiaryRealm.self).count
    }
}
