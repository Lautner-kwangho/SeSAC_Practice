//
//  ShoppingTableViewController.swift
//  SeSACAssignment11
//
//  Created by 최광호 on 2021/10/13.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    var lblChecklist: [ShoppingBasket] = [ShoppingBasket(name: "shopping값은 이렇게 쓰세요!")] {
        didSet {
            saveData()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5416610837, green: 0.7107171416, blue: 0.7037462592, alpha: 1)
        headerView.backgroundColor = #colorLiteral(red: 0.5416610837, green: 0.7107171416, blue: 0.7037462592, alpha: 1)
        txtField.placeholder = "무엇을 구매하실 건가요?"
        btnSave.setTitle("추가", for: .normal)
        btnSave.setTitleColor(.white, for: .normal)
        btnSave.backgroundColor = #colorLiteral(red: 0.3123301864, green: 0.462901473, blue: 0.6003618836, alpha: 1)
        
        loadData()
    }
    
    func saveData() {
        var shoppingBasket: [[String:Any]] = []
        
        for shopping in lblChecklist {
            let data: [String:Any] = [
                "name": shopping.name
            ]
            shoppingBasket.append(data)
        }
        UserDefaults.standard.set(shoppingBasket, forKey: "shoppingBasket")
        tableView.reloadData()
    }
    
    func loadData() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: "shoppingBasket") as? [[String: Any]] {
            var shopping = [ShoppingBasket]()
            for datum in data {
                guard let name = datum["name"] as? String else {return}
//                guard let checkBox = datum["checkBox"] as? Int else {return}
//                guard let favorite = datum["favorite"] as? Int else {return}
            
                shopping.append(ShoppingBasket(name: name))
            }
            self.lblChecklist = shopping
        }
    }
    
    @IBAction func savingList(_ sender: UIButton) {
        
        if let text = txtField.text {
            if text != "" {
                let shop = ShoppingBasket(name: text)
                lblChecklist.append(shop)
                txtField.text = ""
                }
        } else {
            print("들어갈 값이 없습니다")
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.shoppingIdentifier, for: indexPath) as? ShoppingTableViewCell else {
            return UITableViewCell()
        }
        
        let shoppigRow = lblChecklist[indexPath.row]
        
        cell.lblList.text = shoppigRow.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lblChecklist.count
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
                lblChecklist.remove(at: indexPath.row)
            }
        }
    }
}
