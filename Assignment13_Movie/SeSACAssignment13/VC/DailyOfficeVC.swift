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
    
    var dailyDate: String = "00000000"
    
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
        tasks = localRealm.objects(RealmModel.self)
        // 음 나중에 앱 구현할 때는 사람 생각해서 자동 어제 날짜 불러오는 건 삭제해야 되려나..
        // git이랑 시뮬레이터 오류나서 시간 좀 날렷...
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
                    self.dailyOfficeTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func DailySearchButton(_ sender: UIButton) {
        view.endEditing(true)
        dailyDate = dailyTextField.text ?? "00000000"
        dailyTextField.text = ""
        dailyOfficeAPIManager()
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
        tasks.filter("showRange == '\(dailyDate)'").count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nibName = UINib(nibName: DailyOfficeTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: DailyOfficeTableViewCell.identifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyOfficeTableViewCell.identifier) as? DailyOfficeTableViewCell else {return UITableViewCell()}
        
        let rankTasks = tasks.filter("showRange == '\(dailyDate)'").sorted(byKeyPath: "rank", ascending: true)

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
