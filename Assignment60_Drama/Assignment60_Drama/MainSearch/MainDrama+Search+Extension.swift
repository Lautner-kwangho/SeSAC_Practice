//
//  MainDrama+Search+Extension.swift
//  Assignment60_Drama
//
//  Created by 최광호 on 2021/12/27.
//

import UIKit

extension MainDramaCollectionView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
//        if let text = searchController.searchBar.text {
//            text.count > 0 ? print(1) : print(2)
//        }
    }
    
}

extension MainDramaCollectionView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            text.count == 0 ? print(1) : self.navigationController?.pushViewController(DetailDramaTableView(), animated: true)
        }
    }
}
