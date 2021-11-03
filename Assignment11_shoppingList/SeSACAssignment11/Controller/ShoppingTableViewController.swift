//
//  ShoppingTableViewController.swift
//  SeSACAssignment11
//
//  Created by 최광호 on 2021/10/13.
//

import UIKit
import RealmSwift

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    let realm = try! Realm()
    var tasks: Results<RealmModel>!
//    var checkList: [BasketModel] = [BasketModel(name: "shopping값은 이렇게 쓰세요!", selectMark: false, selectStar: false)] {
//        didSet {
////            saveData()
//            tableView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5416610837, green: 0.7107171416, blue: 0.7037462592, alpha: 1)
        headerView.backgroundColor = #colorLiteral(red: 0.5416610837, green: 0.7107171416, blue: 0.7037462592, alpha: 1)
        txtField.placeholder = "무엇을 구매하실 건가요?"
        btnSave.setTitle("추가", for: .normal)
        btnSave.setTitleColor(.white, for: .normal)
        btnSave.backgroundColor = #colorLiteral(red: 0.3123301864, green: 0.462901473, blue: 0.6003618836, alpha: 1)
        
//        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasks = realm.objects(RealmModel.self).sorted(byKeyPath: "selectStar", ascending: false)
    }
    
//    func saveData() {
//        var shoppingBasket: [[String:Any]] = []
//
//        for shopping in checkList {
//            let data: [String:Any] = [
//                "name": shopping.name,
//                "selectMark": shopping.selectMark,
//                "selectStar": shopping.selectStar
//            ]
//            shoppingBasket.append(data)
//        }
//        UserDefaults.standard.set(shoppingBasket, forKey: "shoppingBasket")
//        tableView.reloadData()
//    }
    
//    func loadData() {
//        let userDefaults = UserDefaults.standard
//        if let data = userDefaults.object(forKey: "shoppingBasket") as? [[String: Any]] {
//            var shopping = [BasketModel]()
//            for datum in data {
//                guard let name = datum["name"] as? String else {return}
//                guard let selectMark = datum["selectMark"] as? Bool else {return}
//                guard let selectStar = datum["selectStar"] as? Bool else {return}
//
//                shopping.append(BasketModel(name: name, selectMark: selectMark, selectStar: selectStar))
//            }
//            self.checkList = shopping
//        }
//    }
    
    @IBAction func savingList(_ sender: UIButton) {

        
        if let text = txtField.text {
            if text != "" {
//                let shop = BasketModel(name: text, selectMark: false, selectStar: false)
//                checkList.append(shop)
                let task = RealmModel(name: txtField.text!, selectMark: false, selectStar: false)
                try! realm.write {
                    realm.add(task)
                }
                txtField.text = ""
                self.tableView.reloadData()
            }
        } else {
            print("들어갈 값이 없습니다")
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.shoppingIdentifier, for: indexPath) as? ShoppingTableViewCell else {
            return UITableViewCell()
        }
        
//        let row = checkList[indexPath.row]
        let row = tasks[indexPath.row]
        cell.btnMark.addTarget(self, action: #selector(markClicked(_:)), for: .touchUpInside)
        let mark = row.selectMark ? "checkmark.square.fill" : "checkmark.square"
        cell.btnMark.setImage(UIImage(systemName: mark), for: .normal)
        cell.btnMark.tag = indexPath.row
        
        cell.btnStar.addTarget(self, action: #selector(starClicked(_:)), for: .touchUpInside)
        let star = row.selectStar ? "star.fill" : "star"
        cell.btnStar.setImage(UIImage(systemName: star), for: .normal)
        cell.btnStar.tag = indexPath.row
        
        cell.lblList.text = row.name
        return cell
    }
    
    // 이전 코드 누가 이렇게 짜래 ㅋㅋㅋㅋㅋ 웃기다 나 ㅋㅋㅋ쿠ㅜ 코드 네이밍의 중요성 깨닫..
    @objc func markClicked(_ sender: UIButton) {
        let tasksToUpdate = tasks[sender.tag]
        try! realm.write {
            tasksToUpdate.selectMark = !tasksToUpdate.selectMark
        }
        if tasksToUpdate.selectMark == true {
//.        음 내용이 이렇게 바뀌는 거면 혼자 작성한게 모를거 같으니 alert을 활용해보겠습니다!
//            try! realm.write {
//                tasksToUpdate.name = "완료되었습니다!"
//            }
            let alert = UIAlertController(title: "확인했어요", message: "오늘도 Flex한 하루!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "내 돈ㅠㅠ", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        self.tableView.reloadData()
    }
    
    @objc func starClicked(_ sender: UIButton) {
        let tasksToUpdate = tasks[sender.tag]
        try! realm.write {
            tasksToUpdate.selectStar = !tasksToUpdate.selectStar
        }
        if tasksToUpdate.selectStar == true {
            let sortedTask = tasks.sorted(byKeyPath: "selectStar", ascending: false)
            // 왜 안되지 하면서 3시간은 본 듯... 댕청..ㅠ
            tasks = sortedTask
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 18
    }
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if editingStyle == .delete {
                try! realm.write {
                    realm.delete(tasks[indexPath.row])
                }
                self.tableView.reloadData()
            }
        }
    }
}
