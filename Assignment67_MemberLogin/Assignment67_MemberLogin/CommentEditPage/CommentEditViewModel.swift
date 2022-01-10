//
//  CommentEditViewModel.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/06.
//

import UIKit

class CommentEditViewModel {
    
    let title = "수정"
    var buttonEditTitle = "저장"
    var editText = Observable(String())
    
    var sendToast = Observable(String())
    
    func editComment(_ post: GetCommentElement?, completion: @escaping () -> Void) {
        if let post = post {
            APIManager.commentEdit(MethodTye: .PUT, editText.valueData, post.id, post.post.id) { data, error in
                self.sendToast.valueData = "수정 성공"
            }
            completion()
        }
    }
}

/*
enum Edit: String {
    case edit = "수정되었습니다"
    case notEdit
    
    mutating func next() {
        switch self {
        case .edit:
            self = .notEdit
        case .notEdit:
            self = .edit
        }
    }
}

// struct 사용시 mutating 붙임!
// 할당된 값에 주소가 복사되는 게 아니라 값이 복사되면서 가변 메서드 호출도 안됨!
// 그래서 값 전달은 delegate나 노티 이용하나 봄
// delegate도 화면이랑 화면이랑 연결...
class SendToastMessage {
    
    var toastMessage = Edit.edit
    
    func shiftMessage() {
        toastMessage.next()
    }
}
*/
