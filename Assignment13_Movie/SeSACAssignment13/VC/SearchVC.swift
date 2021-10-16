//
//  SearchVC.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/16.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var SearchTableView: UITableView!
    
    let searchBar = { () -> UISearchBar in
        let search = UISearchBar()
        search.placeholder = "어떤 영화 찾아?"
        return search
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closedClicked))
        self.navigationItem.titleView = searchBar()
        
        // TableView 입력
        SearchTableView.delegate = self
        SearchTableView.dataSource = self
    }
    
    @objc func closedClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        // 나중에 Data받으면 교체!
        cell.imgPoster.image = UIImage(systemName: "network.badge.shield.half.filled")
        cell.posterName.text = "영화제목영화제목영화제목"
        cell.posterRelase.text = "개봉일"
        cell.posterOverview.text = "이 편지는 영국에서 최초로 시작되어 일년에 한바퀴 돌면서 받는 사람에게 행운을 주었고 지금은 당신에게로 옮겨진 이 편지는 4일 안에 당신 곁을 떠나야 합니다. 이 편지를 포함해서 7통을 행운이 필요한 사람에게 보내 주셔야 합니다. 복사를 해도 좋습니다. 혹 미신이라 하실지 모르지만 사실입니다.영국에서 HGXWCH이라는 사람은 1930년에 이 편지를 받았습니다. "
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    
}
