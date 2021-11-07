//
//  CalendarVC+extension.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/07.
//

import FSCalendar

extension CalendarVC: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateFormat = DateFormatter.customFormatter.string(from: date)
        return tasks.filter("diaryDate = %@", dateFormat).count
    }
}
