//
//  VC+ScrollDelegate+Extension.swift
//  Assignment59_RandomBeer
//
//  Created by 최광호 on 2021/12/20.
//

import UIKit

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        guard let header = detailTableView.tableHeaderView as self.headerView else {return}
//        header.scroll
        
//        headerView.snp.makeConstraints { make in
//            make.height.equalTo(300).multipliedBy(0.5).offset(-scrollView.contentOffset.y)
//        }
        
//        .multipliedBy(0.5).offset(-scrollView.contentOffset.y)
        let y = -scrollView.contentOffset.y
        
        if y > 0 {
            headerView.snp.makeConstraints { make in
                make.top.equalTo(view)
                make.width.equalTo(view).multipliedBy(y)
                make.height.equalTo(y).multipliedBy(y)
//                make.bottom.equalTo(detailTableView.snp.top)
            }
        }
        print(y)
    }

}
