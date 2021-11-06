//
//  DailyOfficeVC.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/27.
//
import RealmSwift
import TextFieldEffects
import UIKit

import Alamofire
import SwiftyJSON

class DailyOfficeVC: UIViewController {

    static let identifier = "DailyOfficeVC"
    
    let localRealm = try! Realm()
    var tasks: Results<RealmModel>!
    
    var dailyDate: String = "[0-9]"
    
    @IBOutlet weak var dailyOfficeTableView: UITableView!
    @IBOutlet weak var dailyTextField: UITextField!
    @IBOutlet weak var dailyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateUpdating()
        headerSet()
        
        dailyOfficeTableView.delegate = self
        dailyOfficeTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasks = localRealm.objects(RealmModel.self).filter("showRange == '\(dailyDate)'")
        dailyOfficeAPIManager()
    }
    
    func dateUpdating() {
        if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) {
            let dateFomatter = DateFormatter()
            dateFomatter.dateFormat =  "yyyyMMdd"
            dailyDate = dateFomatter.string(for: yesterday)!
        }
    }
    
    func dailyOfficeAPIManager() {
        let loadTasks = localRealm.objects(RealmModel.self).filter("showRange == '\(dailyDate)'")
        tasks = loadTasks
        if loadTasks.isEmpty {
            let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKEY.OfficeAPI)&targetDt=\(dailyDate)"
            
            AF.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    for dailyDatum in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                        let rank = dailyDatum["rank"].intValue
                        let movieNm = dailyDatum["movieNm"].stringValue
                        let openDt = dailyDatum["openDt"].stringValue
                        //let data = DailyModel(rank: rank, movieNm: movieNm, openDt: openDt)
                        let showRange = json["boxOfficeResult"]["showRange"].stringValue
                        let subStringShowRange = showRange.subString(from: 0, to: 7)
                        let task = RealmModel(rank: rank, movieNm: movieNm, openDt: openDt, showRange: subStringShowRange)
                        try! self.localRealm.write {
                            self.localRealm.add(task)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func dailySearchButton(_ sender: UIButton) {
        view.endEditing(true)
        
        let range = "^(20[1-2][0-9])(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", range)
        let dateTest = predicate.evaluate(with: dailyTextField.text)
        
        if dateTest {
            dailyDate = dailyTextField.text!

            let today = DateFormatter.customFormatter.string(from: Date())
            if Int(dailyDate)! >= Int(today)! {
                alert(title: "죄송하지만", message: "미래 예측은 불가능해요", actionTitle: "확인")
            } else if Int(dailyDate)! < Int(20120301) {
                alert(title: "여기도 죄송하지만", message: "과거 Data가 없어요", actionTitle: "확인")
            } else {
                dailyDate = dailyTextField.text ?? "00000000"
                dailyTextField.text = ""
                dailyOfficeAPIManager()
            }
        } else {
            alert(title: "유효성 오류", message: "YYYYMMDD형식으로 입력해주세요", actionTitle: "확인")
        }
        
        self.dailyOfficeTableView.reloadData()
    }
    
    func headerSet() {
        dailyOfficeTableView.tableHeaderView?.backgroundColor = .clear
        dailyTextField.placeholder = "일일 BoxOffice 날짜로 검색하기"
        dailyTextField.backgroundColor = .clear
        dailyTextField.font = UIFont.systemFont(ofSize: 20)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "바탕화면")!).withAlphaComponent(0.7)
        
        /*
         wheel 하려면 분기 처리알고 있지만.. 나중에 시간되면 ㅜ
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.frame = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.width / 2, width: 0, height: 100)
        dailyTextField.inputView = datePicker
         */
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nibName = UINib(nibName: DailyOfficeTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: DailyOfficeTableViewCell.identifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyOfficeTableViewCell.identifier) as? DailyOfficeTableViewCell else {return UITableViewCell()}
        
        let rankTasks = tasks.sorted(byKeyPath: "rank", ascending: true)
        let row = rankTasks[indexPath.row]
            cell.rankLabel.text = "\(row.rank)"
            cell.movieName.text = row.movieNm
            cell.movieRelease.text = row.openDt
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 22
    }
}
