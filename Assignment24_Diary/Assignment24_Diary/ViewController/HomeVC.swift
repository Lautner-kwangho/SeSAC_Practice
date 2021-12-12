//
//  HomeVC.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //2차원 배열
    let array = [
        Array(repeating: "a", count: 20),
        Array(repeating: "b", count: 10),
        Array(repeating: "c", count: 5),
        Array(repeating: "d", count: 23),
        Array(repeating: "e", count: 25)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarSetting()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func navigationBarSetting() {
        self.title = LocalizationString.HomeVC_Title.localized
        
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(goToAdd))
        navigationItem.rightBarButtonItem = plusButton
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func goToAdd() {
        let sb = UIStoryboard(name: "Add", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: AddVC.identifier) as! AddVC
        let navi = UINavigationController(rootViewController: vc)
        
        navi.modalPresentationStyle = .fullScreen
        
        self.present(navi, animated: true, completion: nil)
    }

}

extension HomeVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.data = array[indexPath.row]
        cell.categoryLabel.backgroundColor = .yellow
        cell.collectionView.backgroundColor = .lightGray
        cell.collectionView.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? 300 : 170
    }
}
