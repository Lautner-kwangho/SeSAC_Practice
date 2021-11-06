//
//  Date+extension.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/11/07.
//

import Foundation

extension DateFormatter {
    static var customFormatter: DateFormatter {
        let date = DateFormatter()
        date.dateFormat = "yyyyMMdd"
        return date
    }
}
