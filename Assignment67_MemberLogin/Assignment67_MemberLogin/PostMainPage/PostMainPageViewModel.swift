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
            guard let userData = userData else {
                print("여기 실행 되면 안되는데")
//                let userDefaults = UserDefaults.standard
//                let id = userDefaults.string(forKey: "LoginID")!
//                let pw = userDefaults.string(forKey: "LoginPW")!
//
//                if error == .badRequest {
//                    DispatchQueue.main.async {
//                        APIManager.login(identifier: id, pw: pw) { userData, error in
//                            userDefaults.removeObject(forKey: "token")
//                            userDefaults.set(userData?.jwt, forKey: "token")
//                            print(userData?.jwt)
//                        }
//                    }
//                } else {
//                    var style = ToastStyle()
//                    style.titleAlignment = .center
//                    vc.view.makeToast("", duration: 1, position: .center, title: "\(error!.errorDescription)", image: nil, style: style, completion: nil)
//                    return
//                }
                return
            }
            // sync : 동기!! 이거 끝나야 다른 거 할 수 있음
            // async: 비동기 !! 다른 일도 동시에 할 수 있다
            DispatchQueue.global().sync {
                // 이거 두개를 잘 조합해야 됨..
                self.tableData.valueData.append(contentsOf: userData)
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }

}
