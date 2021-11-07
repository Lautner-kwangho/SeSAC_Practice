//
//  CalendarVC.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarVC: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var calendarContents: UILabel!
    
    let localRealm = try! Realm()
    var tasks: Results<DiaryRealm>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.delegate = self
        calendarView.dataSource = self
        
        tasks = localRealm.objects(DiaryRealm.self)
        
        labelSetting()
    }
    
    func labelSetting() {
        let allCount = getAllDiaryCountFromUserDiary()
        calendarContents.text = "총 \(allCount)를 작성하셨습니다"
        let a = searchQueryFromUserDiary(text: "헤헤")
        print(a)
    }


}
