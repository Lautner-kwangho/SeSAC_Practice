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
    let buttonTitle: Observable<String> = Observable("저장해!")
    let buttonEditTitle: Observable<String> = Observable("수정해!")
    
    var flag = Observable(Bool())
    var editText: Observable<String> = Observable("")
    var data: GetPostElement?

    
    
    func editButtonClicked(_ vc: UIViewController, completion: @escaping () -> Void) {
        if let data = data, editText.valueData.count > 0 {
            
            APIManager.editPost(MethodTye: .PUT, editText.valueData, data.id) { userEditData, error in
                let userDefaults = UserDefaults.standard
                let id = userDefaults.string(forKey: "LoginID")!
                let pw = userDefaults.string(forKey: "LoginPW")!
                
                guard let userEditData = userEditData else {
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
            }
            completion()
        } else {
            vc.customAlert("없음", "내용이 없습니다", "확인", style: .default, handler: nil)
        }
    }
    
    func saveButtonClicked(_ vc: UIViewController, completion: @escaping () -> Void) {
        if editText.valueData.count > 0 {
            APIManager.writePost(editText.valueData) { userData, error in
                let userDefaults = UserDefaults.standard
                let id = userDefaults.string(forKey: "LoginID")!
                let pw = userDefaults.string(forKey: "LoginPW")!
                
                guard let userData = userData else {
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
                completion()
                DispatchQueue.main.async {
                    APIManager.login(identifier: id, pw: pw) { userData, error in
                        userDefaults.removeObject(forKey: "token")
                        userDefaults.set(userData?.jwt, forKey: "token")
                    }
                }
                
            }
        } else {
            vc.customAlert("없음", "내용이 없습니다", "확인", style: .default, handler: nil)
        }
        
    }
}
