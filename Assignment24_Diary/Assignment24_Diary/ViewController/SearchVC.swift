//
//  SearchVC.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchVC: UIViewController {

    @IBOutlet weak var SearchTableView: UITableView!
    
    let localRealm = try! Realm()
    var tasks: Results<DiaryRealm>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizationString.SearchVC_Title.localized
        tableSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasks = localRealm.objects(DiaryRealm.self)
        self.SearchTableView.reloadData()
    }
    
    func tableSetting() {
        SearchTableView.delegate = self
        SearchTableView.dataSource = self
    }

}
