//
//  Alert+Extension.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/04.
//

import UIKit

extension UIViewController {
    
    typealias alertHandler = ((UIAlertAction) -> Void)?
    
    func customAlert(_ alertTitle: String, _ alertMessage: String, _ actionTitle: String, style: UIAlertAction.Style, handler: alertHandler) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: style, handler: handler)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
}
