//
//  CommentEditViewController.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/06.
//

import UIKit
import Toast

class CommentEditViewController: BaseView {
    
    let textView = UITextView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        $0.sizeToFit()
        $0.isScrollEnabled = false
    }
    
    var editModel: GetCommentElement?
    var viewModel = CommentEditViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let style = ToastStyle()
        let a = self.presentingViewController?.view.description
        print(a) // <- nil ... 아 일단 갱신부터
        presentingViewController?.view.makeToast("", duration: 1, position: .bottom, title: "수정되었습니다", image: nil, style: style, completion: nil)
    }
    
    override func configure() {
        title = viewModel.title
        textView.text = editModel?.comment
        textView.delegate = self
    }
    
    override func setupConstraints() {
        view.addSubview(textView)
        
        textView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        let editButton = UIBarButtonItem(title: viewModel.buttonEditTitle, style: .done, target: self, action: #selector(saveEditButtonClicked))
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func saveEditButtonClicked() {
        viewModel.editComment(editModel) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.editText.valueData = textView.text
    }
    
}
