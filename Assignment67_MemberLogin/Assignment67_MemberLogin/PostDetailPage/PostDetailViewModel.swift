//
//  PostDetailViewModel.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/05.
//

import UIKit

class PostDetailViewModel {
    
    let textPlaceholder = "댓글을 입력해주세요"
    
    func editAction(_ vc: UIViewController, _ element: GetPostElement?) {
        
        
        let myID = UserDefaults.standard.string(forKey: "id")
        
        if let myID = myID, let element = element, myID == String(element.user.id) {
            let alert = UIAlertController(title: "알림", message: "아래에서 선택해주세요", preferredStyle: .alert)
            let edietAction = UIAlertAction(title: "수정", style: .default) { _ in
                let view = WritePostViewController()
                view.editData = element
                view.flag = true
                vc.navigationController?.pushViewController(view, animated: true)
            }
            let deleteAction = UIAlertAction(title: "삭제", style: .default) { _ in
                APIManager.editPost(MethodTye: Method.DELETE, nil, element.id) { userData, error in
                }
                vc.navigationController?.popViewController(animated: true)
            }
            let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            alert.addAction(edietAction)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            vc.present(alert, animated: true)
        } else {
            vc.customAlert("권한", "권한이 없습니다", "🥲", style: .default, handler: nil)
        }
    }
}
