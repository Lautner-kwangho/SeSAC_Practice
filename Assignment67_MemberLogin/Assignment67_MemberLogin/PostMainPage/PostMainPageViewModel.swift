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
    var test = Observable(Int())
    var startPage = Observable(0)
    var limitPage = Observable(10)
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
    
    func getPost(_ vc: UIViewController, _ tableView: UITableView, _ start: Int, _ limit: Int, completion: @escaping () -> Void) {
        APIManager.getPost(start, limit) { userData, error in
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
            // sync : 동기!! 이거 끝나야 다른 거 할 수 있음 이 개념은 알고 있는데 왜 적용이 어려울까요
            // async: 비동기 !! 다른 일도 동시에 할 수 있다 ㅜㅜ
            // 좀만 뭐 고치면 될 듯한데
            DispatchQueue.global().async {
                self.tableData.valueData.append(contentsOf: userData)
                print("모델에서 개수", self.tableData.valueData.count) // 10개 가져오면 다 나와야지 왜 안나옴 ㅡㅡ
                DispatchQueue.main.async {
                    tableView.reloadData()
                    print("여기 나오긴 하니?")
                }
//                tableView.reloadData() //여기에 이렇게 넣으면 막 3개 4개만 나와요,,
//                print(self.startPage)
//                print(self.limitPage)
//                print(self.test)
                
            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                tableView.reloadData()
//                print(self.startPage)
//                print(self.limitPage)
//                print(self.test)
//            }
            
            completion()
        }
    }

}
