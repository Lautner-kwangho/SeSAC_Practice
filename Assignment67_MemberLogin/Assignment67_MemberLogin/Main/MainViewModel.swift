//
//  MainViewModel.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/03.
//

import Foundation
import UIKit

class MainViewModel {
    
    let mainImageName = "logo_white"
    let mainTitleContent = "당신 근처의 새싹농장"
    let subTitleConentn = "iOS지식부터 바람의나라까지\n지금 SeSAC에서 함께해보세요!"
    let start = "시작하기"
    let already = "이미 계정이 있나요?"
    let login = "로그인"
    
    func startButtonClicked(_ viewController: UIViewController) {
        viewController.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    func loginButtonClicked() {
        print("아직 구현 중!")
    }
    
}
