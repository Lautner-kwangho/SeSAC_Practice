//
//  PostDetailViewModel.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/05.
//

import UIKit
import Toast

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

    func sendData(_ textField: UITextField, _ button: UIButton) {
        if textField.text != nil {
            // djswpwkdigkfRK..
            if let text = textField.text, text.count > 0 {
                button.isHidden = false
            } else {
                button.isHidden = true
            }
        }
    }
    
    func commentInput(_ vc: UIViewController, _ postID: GetPostElement?, _ textField: UITextField, completion: @escaping () -> Void) {
        if let comment = textField.text, let postID = postID?.id {
            APIManager.commentWrite(comment, postID) { userData, error in
                textField.text = ""
            }
        }
        completion()
    }

    func commentEdit(_ vc: UIViewController, _ postID: GetPostElement?, _ tag: Int, completion: @escaping () -> Void) {
        print(postID?.id) // 게시물 아이디
        print(postID?.comments[tag].id) // 내 댓글 아이디
        print(postID?.comments[tag].user) // 내꺼

        if let checkID = UserDefaults.standard.string(forKey: "id"), let myID = postID?.comments[tag], checkID == String(myID.user) {
            let alert = UIAlertController(title: "알림", message: "아래에서 선택해주세요", preferredStyle: .alert)
            let edietAction = UIAlertAction(title: "수정", style: .default) { _ in
                let view = CommentEditViewController()
                view.editModel = myID
                vc.navigationController?.pushViewController(view, animated: true)
            }
            let deleteAction = UIAlertAction(title: "삭제", style: .default) { _ in
                APIManager.commentEdit(MethodTye: .DELETE, "", myID.id, myID.post) { data, error in
                }
                let style = ToastStyle()
                vc.view.makeToast("", duration: 0.5, position: .bottom, title: "삭제되었습니다", image: nil, style: style, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            alert.addAction(edietAction)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            vc.present(alert, animated: true)
        } else {
            vc.customAlert("권한", "권한이 없습니다", "🥲", style: .default, handler: nil)
        }
        
        completion()
    }
}
