//
//  ReusableView+Protocol.swift
//  Assignment60_Drama
//
//  Created by 최광호 on 2021/12/24.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}
extension UIViewController: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
