//
//  SearchVC+TableView+extension.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nibName = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        SearchTableView.register(nibName, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        guard let cell = SearchTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.searchImage.backgroundColor = .blue
        cell.searchTitle.text = LocalizationString.SearchAC_TableView_Extension_Title.localized
        cell.SearchDate.text = "\(Date())"
        cell.searchContent.text = LocalizationString.SearchAC_TableView_Extension_Content.localized
        
        
        return cell
    }
    
        
}
