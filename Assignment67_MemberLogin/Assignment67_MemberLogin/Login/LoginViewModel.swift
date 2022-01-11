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
    
    func loginClicked(_ vc: UIViewController) {
        
        APIManager.login(identifier: username.valueData, pw: pw.valueData) { userData, error in
            guard let userData = userData else {
                var style = ToastStyle()
                style.titleAlignment = .center
                vc.view.makeToast("", duration: 1, position: .center, title: "\(error!.errorDescription)", image: nil, style: style, completion: nil)
                return
            }
            
            let userDefaults = UserDefaults.standard
            let domain = Bundle.main.bundleIdentifier!
            
            DispatchQueue.global().sync {
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                
                userDefaults.set(userData.jwt, forKey: "token")
                userDefaults.set(self.username.valueData, forKey: "LoginID")
                userDefaults.set(self.pw.valueData, forKey: "LoginPW")
                userDefaults.set(userData.user.id, forKey: "id")
                userDefaults.set(userData.user.username, forKey: "userName")
                
                //DispatchQueue.main.async {
                APIManager.getPostCount { allCount, error in
                    
                    UserDefaults.standard.removeObject(forKey: "postCount")
                    UserDefaults.standard.set(allCount, forKey: "postCount")
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: PostMainPageViewController())
                    windowScene.windows.first?.makeKeyAndVisible()
                }
            }
        }
        // 빨리 확인하기 위해서 30초 정도 두었습니다!
        // 비효율적이라는 답변받음! 다른 걸로 다시!
        //Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.renewalToken), userInfo: nil, repeats: true)
    }

    @objc func renewalToken() {
//        let userDefaults = UserDefaults.standard
//        let id = userDefaults.string(forKey: "LoginID")!
//        let pw = userDefaults.string(forKey: "LoginPW")!
//        
//        APIManager.login(identifier: id, pw: pw) { userData, error in
//            userDefaults.removeObject(forKey: "token")
//            userDefaults.set(userData?.jwt, forKey: "token")
//        }
//        print("갱신되었습니다")
    }

}
