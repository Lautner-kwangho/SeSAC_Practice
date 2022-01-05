//
//  LoginViewModel.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/04.
//

import UIKit
import Toast

class LoginViewModel {
    
    let title = "새싹농장 로그인"
    let identifierPlaceHolder = "아이디를 입력하세요"
    let passwordPlaceHolder = "비밀번호를 입력하세요"
    
    var username = Observable(String())
    var pw = Observable(String())
    
    var loginButtonTitle: Observable<String> = Observable("로그인")
    
    func sendData(_ identifier: UITextField, _ password: UITextField, _ button: UIButton) {
        if identifier.text != nil, password.text != nil {
            username.valueData = identifier.text!
            pw.valueData = password.text!
            
            if !username.valueData.isEmpty, !pw.valueData.isEmpty {
                button.backgroundColor = .systemGreen
                button.isEnabled = true
            } else {
                button.backgroundColor = .systemGray4
                button.isEnabled = false
            }
        }
    }
    
    func loginClicked(_ vc: UIViewController, completion: @escaping () -> Void) {
        
        APIManager.login(identifier: username.valueData, pw: pw.valueData) { userData, error in
            guard let userData = userData else {
                var style = ToastStyle()
                style.titleAlignment = .center
                vc.view.makeToast("", duration: 1, position: .center, title: "\(error!.errorDescription)", image: nil, style: style, completion: nil)
                return
            }
            
            let userDefaults = UserDefaults.standard
            // 어차피 지울 꺼 한번에 지워도 되지 않을까
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
//            userDefaults.removeObject(forKey: "token")
            userDefaults.set(userData.jwt, forKey: "token")
            userDefaults.set(self.username.valueData, forKey: "LoginID")
            userDefaults.set(self.pw.valueData, forKey: "LoginPW")
            userDefaults.set(userData.user.id, forKey: "id")
            
            vc.view.makeToast("로그인되었습니다")
            
            completion()
        }
        
    }

}
