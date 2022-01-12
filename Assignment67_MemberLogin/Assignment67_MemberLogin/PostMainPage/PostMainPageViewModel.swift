//
//  PostMainPageViewModel.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/04.
//

import UIKit
import Toast

class PostMainPageViewModel: editComplete {
    
    let title = "새싹농장"
    var completeEditMessage = ""
    
    var test = Observable(Int())
    var startPage: Observable<Int> = Observable(0)
    var limitPage: Observable<Int> = Observable(9)
    var tableData = Observable(GetPost())

    var tableViewNumberOfRows: Int {
        var count = 0
        
        tableData.receiveData { value in
            count = value.count
        }
        
        return count
    }
    
    func commentCount(at indexPath: IndexPath) -> String {
        let count = self.tableData.valueData[indexPath.row].comments.count
        return count > 0 ? "댓글 \(count)" : "댓글쓰기"
    }
    
    func dateFormatter(at indexPath: IndexPath) -> String {
        let date = self.tableData.valueData[indexPath.row].createdAt.subString(from: 5, to: 9).replacingOccurrences(of: "-", with: "/")
        return date
    }
    
    func sendMessage(data: Observable<String>) {
        data.receiveData { value in
            self.completeEditMessage = value
        }
    }
    func completeEditMakeToast(_ vc: UIViewController) {
        if completeEditMessage != "" {
            let style = ToastStyle()
            vc.view.makeToast("", duration: 0.5, position: .bottom, title: "변경되었습니다", image: nil, style: style, completion: nil)
            self.completeEditMessage = ""
        }
    }
    func goToMyPage(_ vc: UIViewController) {
        let view = MyPageViewController()
        view.delegate = self
        vc.navigationController?.pushViewController(view, animated: true)
    }
    
    func writePost(_ vc: UIViewController) {
        vc.navigationController?.pushViewController(WritePostViewController(), animated: true)
    }
    
    func viewDidApperAction() {
        DispatchQueue.main.async {
            self.startPage.valueData = 0
            self.tableData.valueData = GetPost()
            let mainView = PostMainPageViewController()
            self.getPost(mainView, PostMainPageViewController.tableView, self.startPage.valueData)
        }
    }
    
    func getPost(_ vc: UIViewController, _ tableView: UITableView, _ start: Int) {
        APIManager.getPost(start) { userData, error in
            let userDefaults = UserDefaults.standard
            let id = userDefaults.string(forKey: "LoginID")!
            let pw = userDefaults.string(forKey: "LoginPW")!
            
            if let userData = userData {
                DispatchQueue.global().sync {
                    self.tableData.valueData.append(contentsOf: userData)
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                }
            } else if error == .badRequest {
                DispatchQueue.global().sync {
                    APIManager.login(identifier: id, pw: pw) { userData, error in
                        userDefaults.removeObject(forKey: "token")
                        userDefaults.set(userData?.jwt, forKey: "token")
                        APIManager.getPost(start) { recallData, error in
                            
                            guard let recallData = recallData else { return }
                            
                            self.tableData.valueData.append(contentsOf: recallData)
                            DispatchQueue.main.async {
                                tableView.reloadData()
                            }
                        }
                        
                        APIManager.getPostCount { allCount, error in
                            userDefaults.removeObject(forKey: "postCount")
                            userDefaults.set(allCount, forKey: "postCount")
                        }
                    }
                }
            }
        }
    }
}
