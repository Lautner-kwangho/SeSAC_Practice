//
//  Alert+extension.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/07.
//

import UIKit

extension UIViewController {
    func alert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
