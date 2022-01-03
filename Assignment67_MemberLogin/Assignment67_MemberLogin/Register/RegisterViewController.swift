//
//  RegisterViewController.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/03.
//

import UIKit

class RegisterViewController: BaseView {
    
    let emailTextField = UITextField().then {
        // 반복되니까 커스텀하면 좋을 듯 일단 과제 구현은 하고 제출하기 전 수정
        $0.setLeftPaddingPoints()
        $0.setRightPaddingPoints()
        $0.setBorderLine()
    }
    let nicknameTextField = UITextField().then {
        $0.setLeftPaddingPoints()
        $0.setRightPaddingPoints()
        $0.setBorderLine()
    }
    let passwordTextField = UITextField().then {
        $0.setLeftPaddingPoints()
        $0.setRightPaddingPoints()
        $0.setBorderLine()
    }
    let confirmTextField = UITextField().then {
        $0.setLeftPaddingPoints()
        $0.setRightPaddingPoints()
        $0.setBorderLine()
    }
    let registerButton = UIButton().then {
        // 버튼 반복도 customView로 만들어도...
        $0.backgroundColor = .systemGray4
    }
    
    let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        title = viewModel.title
        emailTextField.placeholder = viewModel.emailPlaceHolder
        emailTextField.addTarget(self, action: #selector(sendData), for: .editingChanged)
        
        nicknameTextField.placeholder = viewModel.nicknamePlaceHolder
        nicknameTextField.addTarget(self, action: #selector(sendData), for: .editingChanged)
        
        passwordTextField.placeholder = viewModel.passwordPlaceHolder
        passwordTextField.addTarget(self, action: #selector(sendData), for: .editingChanged)
        
        confirmTextField.placeholder = viewModel.confirmPlaceHolder
        confirmTextField.addTarget(self, action: #selector(sendData), for: .editingChanged)
        
        
        viewModel.registerName.receiveData { title in
            self.registerButton.setTitle(title, for: .normal)
        }
        
        self.registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
    }
    
    @objc func sendData() {
        viewModel.sendData(self.emailTextField, self.nicknameTextField, self.passwordTextField, self.confirmTextField)
    }
    
    @objc func registerButtonClicked() {
        viewModel.registerMember(self) {
            print(1)
        }
    }
    
    override func setupConstraints() {
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(confirmTextField)
        confirmTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints {
            $0.top.equalTo(confirmTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
