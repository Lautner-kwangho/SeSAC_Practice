//
//  DDayViewController.swift
//  SeSACAssignment7
//
//  Created by 최광호 on 2021/10/07.
//

import UIKit

class DDayViewController: UIViewController {
    
    // 21년 10월 7일 수업 내용
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var img1: UIImageView!
    @IBOutlet var img2: UIImageView!
    @IBOutlet var img3: UIImageView!
    @IBOutlet var img4: UIImageView!
    
    @IBOutlet var lblsub1: UILabel!
    @IBOutlet var lblsub2: UILabel!
    @IBOutlet var lblsub3: UILabel!
    @IBOutlet var lblsub4: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else if #available(iOS 13.4, *){
            datePicker.preferredDatePickerStyle = .wheels
        }
        // local 설정
        datePicker.locale = Locale(identifier: "Korean")
        
        imgSetting()
        lblSetting(lblsub1)
        lblSetting(lblsub2)
        lblSetting(lblsub3)
        lblSetting(lblsub4)
    }
    
    func imgSetting() {
        img1.layer.cornerRadius = 10
        img2.layer.cornerRadius = 10
        img3.layer.cornerRadius = 10
        img4.layer.cornerRadius = 10
    }
    func lblSetting(_ lbl: UILabel) {
        lbl.text = ""
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
    }

    @IBAction func datePickValueChanged(_ sender: UIDatePicker) {
        let format = DateFormatter()
        format.dateFormat = "yyyy년\nMM월 dd일"
        
        let afterDay = Date(timeInterval: 86400 * 100, since: sender.date)
        let afterDDay = format.string(from: afterDay)
        lblsub1.text = "\(afterDDay)"
        
        let bfterDay = Date(timeInterval: 86400 * 200, since: sender.date)
        let bfterDDay = format.string(from: bfterDay)
        lblsub2.text = "\(bfterDDay)"
        
        let cfterDay = Date(timeInterval: 86400 * 300, since: sender.date)
        let cfterDDay = format.string(from: cfterDay)
        lblsub3.text = "\(cfterDDay)"
        
        let dfterDay = Date(timeInterval: 86400 * 400, since: sender.date)
        let dfterDDay = format.string(from: dfterDay)
        lblsub4.text = "\(dfterDDay)"

//
//        // format 여러 구조로 사용되는지 확인
//        // 100일 뒤에 날짜 계산하는 방법 TimeInterval, Calendar
//        // 간단한 방법 (100일 뒤)
//        let afterDate = Date(timeInterval: 86400 * 100, since: sender.date)
//        print(afterDate)
    }
}
