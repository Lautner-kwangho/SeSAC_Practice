//
//  ShoppingTVC+Filter+Extension.swift
//  SeSACAssignment11
//
//  Created by 최광호 on 2021/11/06.
//

import UIKit
import RealmSwift
import SwiftUI

extension ShoppingTableViewController {
    func filterAlert() {
        listFilterButton.addTarget(self, action: #selector(alert), for: .touchUpInside)
    }
    
    @objc func alert() {
        let alert = UIAlertController(title: "필터링", message: "어떻게 보여드릴까요?", preferredStyle: .actionSheet)
        let favorite = UIAlertAction(title: "Favorite", style: .default) { _ in
            let favoriteFilter = self.realm.objects(RealmModel.self).filter("selectMark = true")
            self.tasks = favoriteFilter
            self.tableView.reloadData()
        }
        let book = UIAlertAction(title: "Book", style: .default) { _ in
            let bookFilter = self.realm.objects(RealmModel.self).filter("selectStar = true")
            self.tasks = bookFilter
            self.tableView.reloadData()
        }
        let all = UIAlertAction(title: "All", style: .default) { _ in
            let allTask = self.realm.objects(RealmModel.self).sorted(byKeyPath: "selectStar", ascending: false)
            self.tasks = allTask
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let actionList = [favorite, book, all, cancel]
        actionList.map { alert.addAction($0) }
        
        self.present(alert, animated: true)
    }
}
