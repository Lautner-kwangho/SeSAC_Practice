//
//  RegisterViewModel.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/03.
//

import UIKit
import Toast

class RegisterViewModel {
    let title = "새싹농장 가입하기"
    let emailPlaceHolder = "이메일 주소"
    let nicknamePlaceHolder = "닉네임"
    let passwordPlaceHolder = "비밀번호"
    let confirmPlaceHolder = "비밀번호 확인"
    
    var email = Observable(String())
    var nickname = Observable(String())
    var password = Observable(String())
    var confirm = Observable(String())
    
    var registerName: Observable<String> = Observable("가입하기")
    
    func sendData(_ emailText: UITextField, _ nicknameText: UITextField, _ passwordText: UITextField, _ comfirmText: UITextField) {
        if emailText.text != nil, nicknameText.text != nil, passwordText.text != nil, comfirmText.text != nil {
            email.valueData = emailText.text!
            nickname.valueData = nicknameText.text!
            password.valueData = passwordText.text!
            confirm.valueData = comfirmText.text!
            
            if password.valueData.count > 0, password.valueData == confirm.valueData {
                print("맞음")
            } else {
                print("다름")
            }
        }
        print(email.valueData)
        print(nickname.valueData)
        print(password.valueData)
        print(confirm.valueData)
    }
    
    func registerMember(_ vc: UIViewController, completion: @escaping () -> Void) {
        APIManager.login(username: nickname.valueData, email: email.valueData, password: password.valueData) { userData, error in
            guard let userData = userData else {
                var style = ToastStyle()
                style.titleAlignment = .center
                vc.view.makeToast("", duration: 1, position: .center, title: "\(error!.errorDescription)", image: nil, style: style, completion: nil)
                return
            }
            
            print(userData)
            
            completion()
            print(completion())
        }
    }
}
