//
//  MyPageViewModel.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/08.
//

import UIKit
import Toast

class MyPageViewModel {
    
    let title = "비밀번호 바꾸기"
    let logOutTitle = "로그아웃하기"
    let userName = "안녕하세요!\n\(UserDefaults.standard.string(forKey: "userName")!)님"
    let currentPlaceHolder = "현재 비밀번호를 입력하세요"
    let newPasswordPlaceHolder = "변경할 비밀번호를 입력하세요"
    let confirmPasswordPlaceHolder = "변경할 비밀번호를 한번 더 입력해주세요"
    let buttonTitle = "비밀번호 변경하기"
    
    let userDefaults = UserDefaults.standard
    
    var currentText = Observable(String())
    var newText = Observable(String())
    var confirmText = Observable(String())
    var sendToast = Observable(String())
    
    func sendData(_ current: UITextField, _ new: UITextField, _ confirm: UITextField, _ button: UIButton) {
        if let current = current.text, let new = new.text, let confirm = confirm.text {
            currentText.valueData = current
            newText.valueData = new
            confirmText.valueData = confirm
            
            if current.count > 0, new.count > 0, confirm.count > 0 {
                button.backgroundColor = .systemGreen
                button.isEnabled = true
            } else {
                button.backgroundColor = .systemGray4
                button.isEnabled = false
            }
        }
    }
    
    func clickedButton(_ vc: UIViewController) {
        let userPassword = UserDefaults.standard.string(forKey: "LoginPW")
        
        if currentText.valueData != userPassword {
            vc.view.makeToast("현재 비밀번호와 다릅니다")
        } else if newText.valueData != confirmText.valueData {
            vc.view.makeToast("변경할 비밀번호가 일치하지 않습니다")
        } else {
            APIManager.changePassword(currentPassword: currentText.valueData, newPassword: newText.valueData, confirmNewPassword: confirmText.valueData) { userData, error in
                
//                let userDefaults = UserDefaults.standard
                let id = self.userDefaults.string(forKey: "LoginID")!
                let pw = self.userDefaults.string(forKey: "LoginPW")!
//
                guard let userData = userData else {
                    
                    if error == .badRequest {
                        DispatchQueue.main.async {
                            APIManager.login(identifier: id, pw: pw) { userData, error in
                                self.userDefaults.removeObject(forKey: "token")
                                self.userDefaults.set(userData?.jwt, forKey: "token")
                            }
                        }
                    } else {
                        var style = ToastStyle()
                        style.titleAlignment = .center
                        vc.view.makeToast("", duration: 1, position: .center, title: "\(error!.errorDescription)", image: nil, style: style, completion: nil)
                        return
                    }
                    return
                }
                
                self.userDefaults.removeObject(forKey: "LoginPW")
                self.userDefaults.set(self.confirmText.valueData, forKey: "LoginPW")
                self.sendToast.valueData = "변경완료"
                vc.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func clickedLogOutButton(_ vc: UIViewController) {
        vc.customAlert2("로그아웃", "정말 로그아웃 하시겠습니까?", "네!", style1: .default, handler1: { _ in
            DispatchQueue.global().sync {
                // 전부 삭제
                let domain = Bundle.main.bundleIdentifier!
                self.userDefaults.removePersistentDomain(forName: domain)
                self.userDefaults.synchronize()
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
                
            }
        }, "아니요 ㅜ", style2: .destructive, handler2: nil)
    }
}
