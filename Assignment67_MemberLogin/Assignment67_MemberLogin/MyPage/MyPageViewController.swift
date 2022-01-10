//
//  MyPageViewController.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/08.
//

import UIKit

class MyPageViewController: BaseView {
    
    let name = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.adjustsFontSizeToFitWidth = true
    }
    let currentPassword = UITextField().then {
        $0.setLeftPaddingPoints()
        $0.setRightPaddingPoints()
        $0.setBorderLine()
    }
    let newPassword = UITextField().then {
        $0.setLeftPaddingPoints()
        $0.setRightPaddingPoints()
        $0.setBorderLine()
    }
    let confirmPassword = UITextField().then {
        $0.setLeftPaddingPoints()
        $0.setRightPaddingPoints()
        $0.setBorderLine()
    }
    let editbutton = UIButton().then {
        $0.backgroundColor = .systemGray4
        $0.isEnabled = false
    }
    var viewModel = MyPageViewModel()
    var delegate: editComplete?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.sendMessage(data: viewModel.sendToast)
    }
    
    override func configure() {
        title = viewModel.title
        
        name.text = viewModel.userName
        
        currentPassword.placeholder = viewModel.currentPlaceHolder
        currentPassword.addTarget(self, action: #selector(checkText), for: .editingChanged)
        newPassword.placeholder = viewModel.newPasswordPlaceHolder
        newPassword.addTarget(self, action: #selector(checkText), for: .editingChanged)
        confirmPassword.placeholder = viewModel.newPasswordPlaceHolder
        confirmPassword.addTarget(self, action: #selector(checkText), for: .editingChanged)
        
        editbutton.setTitle(viewModel.buttonTitle, for: .normal)
        editbutton.addTarget(self, action: #selector(editButtonClicked), for: .touchUpInside)
    }
    
    @objc func checkText() {
        viewModel.sendData(currentPassword, newPassword, confirmPassword, editbutton)
    }
    
    @objc func editButtonClicked() {
        viewModel.clickedButton(self)
    }
    
    override func setupConstraints() {
        view.addSubview(name)
        name.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        view.addSubview(currentPassword)
        currentPassword.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(newPassword)
        newPassword.snp.makeConstraints {
            $0.top.equalTo(currentPassword.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(confirmPassword)
        confirmPassword.snp.makeConstraints {
            $0.top.equalTo(newPassword.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(editbutton)
        editbutton.snp.makeConstraints {
            $0.top.equalTo(confirmPassword.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        
    }
    
}
