//
//  BaseCollectionView.swift
//  Assignment60_Drama
//
//  Created by 최광호 on 2021/12/24.
//

import UIKit
import SnapKit
import Then

class BaseCollectionView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupConstraints()
    }
    
    func configure() {
        // 구성
    }

    func setupConstraints() {
        // 레이아웃
    }
}

extension BaseCollectionView: UICollectionViewDelegate {
    
}

extension BaseCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}

extension BaseCollectionView: UICollectionViewDelegateFlowLayout {
    
}
