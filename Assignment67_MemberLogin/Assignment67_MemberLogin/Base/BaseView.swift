//
//  BaseView.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/03.
//

import UIKit
import SnapKit
import Then

protocol BaseRepresentable {
    func configure()
    func setupConstraints()
}

class BaseView: UIViewController, BaseRepresentable {
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        setupConstraints()
        configure()
    }
    
    func configure() {
        
    }
    
    func setupConstraints() {
         
    }
    
    
}
