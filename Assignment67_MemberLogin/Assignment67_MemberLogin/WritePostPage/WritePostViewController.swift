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
    var editData: GetPostElement?
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(editData)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        flag = false
    }
    
    override func configure() {
        viewModel.data = self.editData
        if let editData = editData {
            textView.text = editData.text
        }
        
        viewModel.flag.valueData = self.flag
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
    
    @objc func saveEditButtonClicked() {
        viewModel.editButtonClicked(self) {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: PostMainPageViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }
    
    override func setupConstraints() {
        view.addSubview(textView)
        textView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.editText.valueData = textView.text
        if flag {
            let editButton = UIBarButtonItem(title: viewModel.buttonEditTitle.valueData, style: .done, target: self, action: #selector(saveEditButtonClicked))
            self.navigationItem.rightBarButtonItem = editButton
        } else {
            let saveButton = UIBarButtonItem(title: viewModel.buttonTitle.valueData, style: .done, target: self, action: #selector(saveButtonClicked))
            self.navigationItem.rightBarButtonItem = saveButton
        }
    }
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        viewModel.editText.valueData = textView.text
//    }
}


