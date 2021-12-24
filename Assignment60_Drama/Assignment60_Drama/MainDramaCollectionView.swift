//
//  MainDramaCollectionView.swift
//  Assignment60_Drama
//
//  Created by 최광호 on 2021/12/24.
//

import UIKit

class MainDramaCollectionView: BaseCollectionView {
    
    var tvData: TV?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiRequest()
        configure()
        setupConstraints()
    }
    
    func apiRequest() {
        APIManager.shared.tvPopularAPI { tv in
            self.tvData = tv
            
            DispatchQueue.main.async {
//                dump(self.tvData)
            }
        }
    }

    override func configure() {
        view.backgroundColor = .blue
    }

    override func setupConstraints() {
        
    }
    
}

