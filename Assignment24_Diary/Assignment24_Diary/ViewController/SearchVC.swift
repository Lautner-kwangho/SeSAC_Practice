//
//  SearchVC.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var SearchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizationString.SearchVC_Title.localized
        tableSetting()
    }
    
    func tableSetting() {
        SearchTableView.delegate = self
        SearchTableView.dataSource = self
    }

}
