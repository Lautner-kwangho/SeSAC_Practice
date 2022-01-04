//
//  Reusable+Extension.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/03.
//

import UIKit

protocol ReusableName {
    static var reuseIdentifier: String { get }
}


extension UITableViewCell: ReusableName {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
