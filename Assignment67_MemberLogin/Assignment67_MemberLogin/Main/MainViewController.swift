//
//  MainViewController.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2021/12/30.
//

import UIKit

class MainViewController: BaseView {
    
    let mainImage = UIImageView()
    let mainTitle = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.adjustsFontSizeToFitWidth = true
        $0.textAlignment = .center
    }
    let subTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.adjustsFontSizeToFitWidth = true
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    let startButton = UIButton().then {
        $0.backgroundColor = #colorLiteral(red: 0.2158010304, green: 0.8206508756, blue: 0.3738011122, alpha: 1)
        $0.layer.cornerRadius = 10
    }
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    let alreadyTitle = UILabel()
    let loginButton = UIButton().then {
        $0.setTitleColor(.systemGreen, for: .normal)
    }
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        mainImage.image = UIImage(named: viewModel.mainImageName)
        mainTitle.text = viewModel.mainTitleContent
        subTitle.text = viewModel.subTitleConentn
        
        startButton.setTitle(viewModel.start, for: .normal)
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        
        alreadyTitle.text = viewModel.already
        
        loginButton.setTitle(viewModel.login, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        viewModel.startButtonClicked(self)
    }
    
    @objc func loginButtonClicked() {
        viewModel.loginButtonClicked(self)
    }
    
    override func setupConstraints() {
        // snp
        view.addSubview(mainImage)
        mainImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-100)
            $0.width.equalTo(100)
            $0.height.equalTo(mainImage.snp.width)
            //            $0.leading.trailing.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(view.frame.width / 3)
        }
        
        view.addSubview(mainTitle)
        mainTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainImage.snp.bottom).offset(10)
            $0.leading.trailing.lessThanOrEqualToSuperview()
        }

        view.addSubview(subTitle)
        subTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainTitle.snp.bottom).offset(10)
            $0.leading.trailing.lessThanOrEqualToSuperview()
        }
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(alreadyTitle)
        stackView.addArrangedSubview(loginButton)
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.lessThanOrEqualToSuperview().inset(view.frame.width / 4)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(stackView.snp.top).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
    
}
