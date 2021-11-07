//
//  SearchVC+TableView+extension.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nibName = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        SearchTableView.register(nibName, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        guard let cell = SearchTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else { return UITableViewCell() }
        
        let row = tasks[indexPath.row]
        
        cell.searchImage.backgroundColor = .blue
        cell.searchTitle.text = row.diaryTitle
        cell.SearchDate.text = "\(row.diaryDate)"
        cell.searchContent.text = row.diaryContent
    
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let row = tasks[indexPath.row]
        try! localRealm.write {
            localRealm.delete(row)
            tableView.reloadData()
        }
    }
    
        
}
