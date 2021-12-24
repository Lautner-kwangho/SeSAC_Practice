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
        let top = scrollView.contentInset.top
        
        var newRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: y)
        if y > 50 {
            headerView.snp.makeConstraints { make in
                make.top.equalTo(view)
//                make.width.equalTo(view).multipliedBy(y)
//                make.height.equalTo(y).multipliedBy(y)
//                make.bottom.equalTo(detailTableView.snp.top)
            }
            headerView.frame = newRect
        } else if y < 50 {
            headerView.snp.makeConstraints { make in
                make.height.equalTo(50).offset(-y)
            }
        }
        print(y)
        print(top)
    }

}
