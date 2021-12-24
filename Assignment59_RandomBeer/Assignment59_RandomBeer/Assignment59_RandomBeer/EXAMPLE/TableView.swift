//
//  TableView.swift
//  Assignment59_RandomBeer
//
//  Created by 최광호 on 2021/12/24.
//

import UIKit

/*
 5. tableViewHeader를 아까 만든 헤더로 설정 (frame은 설정해줘야 함)
 6.(핵심) - Delegate에서 CustomView를 다운케스팅해줘서 사용
 */

class TableView: UIViewController {
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let headerView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250))

        headerView.imageView.image = UIImage(named: "headerbg")
        self.tableView.tableHeaderView = headerView
    }
}

extension TableView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! StretchyTableHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }
}
