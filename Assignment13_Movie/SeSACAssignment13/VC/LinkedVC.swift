//
//  LinkedViewController.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/18.
//

import UIKit
import Kingfisher
import WebKit

class LinkedVC: UIViewController {
    static let identifier = "LinkedVC"
    
    @IBOutlet weak var linkedTableView: UITableView!
    var linkDB: MainModel?
    var linkData: [LinkModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        linkedTableView.backgroundColor = .black
        self.navigationItem.title = linkDB?.title
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        if let type = linkDB?.media_type, let ID = linkDB?.id {
            callLinkedData(type: type, genreID: ID)
        }
        let nibName = UINib(nibName: LinkedTableViewCell.identifier, bundle: nil)
        linkedTableView.register(nibName, forCellReuseIdentifier: LinkedTableViewCell.identifier)
        
        linkedTableView.delegate = self
        linkedTableView.dataSource = self
    }
    
}

extension LinkedVC {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LinkedTableViewCell.identifier, for: indexPath) as? LinkedTableViewCell else {
            return LinkedTableViewCell()
        }
        let item = linkData[indexPath.row]
        cell.linkedName.text = item.name
        cell.linkedWebView.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(item.key)?autoplay=0")!))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height / 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.linkData.count
    }
}
