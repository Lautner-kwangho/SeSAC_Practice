//
//  SettingTableViewController.swift
//  SeSACAssignment10
//
//  Created by 최광호 on 2021/10/12.
//

import UIKit

class SettingTableViewController: UITableViewController {

    let sectionA: [String] = ["공지사항", "실험실", "버전정보"]
    let sectionB: [String] = ["개인/보안", "알림", "채팅", "멀티프로필"]
    let sectionC: [String] = ["고객센터/도움말"]
    
    let sectionHeadTitle: [String] = ["전체설정", "개인설정", "기타"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeadTitle.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? sectionA.count : section == 1 ? sectionB.count : sectionC.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "setting") else {
            return UITableViewCell()
        }
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = sectionA[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = sectionB[indexPath.row]
        } else {
            cell.textLabel?.text = sectionC[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        tableView.tintColor = .gray
        return sectionHeadTitle[section]
        
    }
}
