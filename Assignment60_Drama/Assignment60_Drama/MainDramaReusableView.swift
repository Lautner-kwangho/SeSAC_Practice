//
//  MainDramaReusableView.swift
//  Assignment60_Drama
//
//  Created by 최광호 on 2021/12/26.
//

import UIKit

class MainDramaReusableView: UICollectionReusableView {
    let label = UILabel().then {
        $0.text = "영화 및 TV 프로그램"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .white
        $0.sizeToFit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.centerY.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
