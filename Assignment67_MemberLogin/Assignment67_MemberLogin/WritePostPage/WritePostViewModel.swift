//
//  WritePostViewModel.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/05.
//

import UIKit
import Toast

class WritePostViewModel {
    let title = "새싹농장 글쓰기"
    var text = Observable(String())

    func saveButtonClicked(_ vc: UIViewController, completion: @escaping () -> Void) {
        
        APIManager.writePost(text.valueData) { userData, error in
            guard let userData = userData else {
                
                let userDefaults = UserDefaults.standard
                let id = userDefaults.string(forKey: "id")!
                let pw = userDefaults.string(forKey: "pw")!
                
                if error == .badRequest {
                    APIManager.login(identifier: id, pw: pw) { userData, error in
                        userDefaults.removeObject(forKey: "token")
                        userDefaults.set(userData?.jwt, forKey: "token")
                    }
                } else {
                    var style = ToastStyle()
                    style.titleAlignment = .center
                    vc.view.makeToast("", duration: 1, position: .center, title: "\(error!.errorDescription)", image: nil, style: style, completion: nil)
                    return
                }
                return
            }
            
            print(userData)
            completion()
        }
    }
}
