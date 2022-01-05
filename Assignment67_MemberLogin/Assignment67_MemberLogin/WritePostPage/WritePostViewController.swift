//
//  WritePostViewController.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/05.
//

import UIKit

class WritePostViewController: BaseView {
    let textView = UITextView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
    }
    
    let viewModel = WritePostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        title = viewModel.title
        
        textView.delegate = self
    }
    
    @objc func saveButtonClicked() {
        viewModel.saveButtonClicked(self) {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func setupConstraints() {
        view.addSubview(textView)
        textView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        let saveButton = UIBarButtonItem(title: "저장해!", style: .done, target: self, action: #selector(saveButtonClicked))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.text.valueData = textView.text
    }
}


