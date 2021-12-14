//
//  CustomStackView.swift
//  Assignment54_LayoutOnlyCode
//
//  Created by 최광호 on 2021/12/14.
//

import UIKit

class CustomStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.spacing = 0
        self.alignment = .fill
        self.distribution = .fillEqually
        self.axis = .horizontal
        
//        self.backgroundColor = .red
//        self.isLayoutMarginsRelativeArrangement = true
//        self.layoutMargins.right = 10
//        self.layoutMargins.left = 10
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
