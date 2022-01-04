//
//  LoginViewController.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/04.
//

import UIKit

class LoginViewController: BaseView {
    /*
    - jwt: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTc2LCJpYXQiOjE2NDEyODk0ODAsImV4cCI6MTY0Mzg4MTQ4MH0.9NPxi6-jkvz6aftueXk_uRnVwXJLLCAySAWOtofy7ZQ"
    ▿ user: Assignment67_MemberLogin.User
      - id: 176
      - username: "Qweqwe"
      - email: "qq@gamil.com"
      - password: As
    */
    
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
        viewModel.loginClicked(self) {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: PostMainPageViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
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
