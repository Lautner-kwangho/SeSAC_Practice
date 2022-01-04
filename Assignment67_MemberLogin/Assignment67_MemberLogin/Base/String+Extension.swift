//
//  String+Extension.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/05.
//

import UIKit

extension String {
    func subString(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1)
        
        return String(self[startIndex ..< endIndex])
    }
}
