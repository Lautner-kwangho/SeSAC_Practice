//
//  CommentEditViewModel.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/06.
//

import UIKit

class CommentEditViewModel {
    let title = "수정"
    let buttonEditTitle = "저장"
    var editText = Observable(String())
    
    func editComment(_ post: GetCommentElement?, completion: @escaping () -> Void) {
        if let post = post {
            APIManager.commentEdit(MethodTye: .PUT, editText.valueData, post.id, post.post.id) { data, error in
                 
            }
            completion()
        }
    }
}
