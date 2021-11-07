//
//  AddVC+textField+extension.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/07.
//

import UIKit

extension AddVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func placeholder() {
        let textView = self.addTextField
        if textView?.text == "" {
            textView?.textColor = .lightGray
            textView?.text = "내용을 입력해주세요"
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "내용을 입력해주세요"
            textView.textColor = .lightGray
        }
    }
    
}
