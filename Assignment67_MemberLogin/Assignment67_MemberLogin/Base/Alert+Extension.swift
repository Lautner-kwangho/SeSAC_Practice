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
    
    // 음 함수 만들어서 이렇게 써보려니 차라리 그냥 직접 쓰는 게 효율적같아요...
    func customAlert2(_ alertTitle: String, _ alertMessage: String, _ actionTitle1: String, style1: UIAlertAction.Style, handler1: alertHandler, _ actionTitle2: String, style2: UIAlertAction.Style, handler2: alertHandler) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let edietAction = UIAlertAction(title: actionTitle1, style: style1, handler: handler1)
        let deleteAction = UIAlertAction(title: actionTitle2, style: style2, handler: handler2)
        alert.addAction(edietAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true)
    }
}
