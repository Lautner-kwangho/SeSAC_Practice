//
//  MainDramaCell.swift
//  Assignment60_Drama
//
//  Created by 최광호 on 2021/12/26.
//

import UIKit

class MainDramaCell: UICollectionViewCell {
    
    let imageView = UIImageView().then {
        $0.backgroundColor = .systemGray4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
