//
//  PostMainPageViewModel.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/04.
//

import UIKit
import Toast

class PostMainPageViewModel {
    let title = "새싹농장"
    var tableData = Observable(GetPost())

    var tableViewNumberOfRows: Int {
        return tableData.valueData.first?.text.count ?? 0
    }
    
    func commentCount(at indexPath: IndexPath) -> String {
        let count = self.tableData.valueData[indexPath.row].comments.count
        return count > 0 ? "댓글 \(count)" : "댓글쓰기"
    }
    
    func dateFormatter(at indexPath: IndexPath) -> String {
        let date = self.tableData.valueData[indexPath.row].createdAt.subString(from: 5, to: 9).replacingOccurrences(of: "-", with: "/")
        return date
    }
    
    func writePost(_ vc: UIViewController) {
        vc.navigationController?.pushViewController(WritePostViewController(), animated: true)
    }
    
    func getPost(_ vc: UIViewController, _ tableView: UITableView, completion: @escaping () -> Void) {
        APIManager.getPost { userData, error in
            guard let userData = userData else {
                
                let userDefaults = UserDefaults.standard
                let id = userDefaults.string(forKey: "LoginID")!
                let pw = userDefaults.string(forKey: "LoginPW")!
                
                if error == .badRequest {
                    DispatchQueue.main.async {
                        APIManager.login(identifier: id, pw: pw) { userData, error in
                            userDefaults.removeObject(forKey: "token")
                            userDefaults.set(userData?.jwt, forKey: "token")
                        }
                    }
                } else {
                    var style = ToastStyle()
                    style.titleAlignment = .center
                    vc.view.makeToast("", duration: 1, position: .center, title: "\(error!.errorDescription)", image: nil, style: style, completion: nil)
                    return
                }
                return
            }
            DispatchQueue.main.async {
                self.tableData.valueData = userData
//                tableView.reloadData()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                tableView.reloadData()
            })
            
            completion()
        }
    }
}
