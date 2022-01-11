//
//  LoginViewController.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/04.
//

import UIKit

class LoginViewController: BaseView {
    
    let identifierField = UITextField().then {
        $0.setLeftPaddingPoints()
        $0.setRightPaddingPoints()
        $0.setBorderLine()
    }
    let passwordField = UITextField().then {
        $0.setLeftPaddingPoints()
        $0.setRightPaddingPoints()
        $0.setBorderLine()
    }
    let loginButton = UIButton().then {
        $0.backgroundColor = .systemGray4
        $0.isEnabled = false
    }
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    /*
    // test 용으로 적은거라 나중에 수정할 때 사용
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.identifierField.text = "any"
        self.passwordField.text = "any "
    }
    */
    
    override func configure() {
        
        title = viewModel.title
        identifierField.placeholder = viewModel.identifierPlaceHolder
        identifierField.addTarget(self, action: #selector(sendData), for: .editingChanged)
        
        passwordField.placeholder = viewModel.passwordPlaceHolder
        passwordField.addTarget(self, action: #selector(sendData), for: .editingChanged)
        
        viewModel.loginButtonTitle.receiveData { text in
            self.loginButton.setTitle(text, for: .normal)
        }
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    @objc func sendData() {
        viewModel.sendData(identifierField, passwordField, loginButton)
    }
    
    @objc func loginButtonClicked() {
        viewModel.loginClicked(self)
    }
    
    override func setupConstraints() {
        view.addSubview(identifierField)
        identifierField.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(passwordField)
        passwordField.snp.makeConstraints {
            $0.top.equalTo(identifierField.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
