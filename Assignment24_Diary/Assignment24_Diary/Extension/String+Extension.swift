//
//  String+Extension.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import Foundation

extension String {
    var localized: String { return NSLocalizedString(self, comment: "") }
    
    func getArrayAfterRegex(regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
