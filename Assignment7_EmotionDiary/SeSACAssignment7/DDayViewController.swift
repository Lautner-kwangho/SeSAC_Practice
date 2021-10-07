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
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
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
        
        let cfterDay = Calendar.current.date(byAdding: .day, value: 300, to: sender.date)
        let cfterDDay = format.string(from: cfterDay!)
        lblsub3.text = "\(cfterDDay)"
        
        let dfterDay = Calendar.current.date(byAdding: .day, value: 400, to: sender.date)
        let dfterDDay = format.string(from: dfterDay!)
        lblsub4.text = "\(dfterDDay)"
        
        /*
        3번째 방법
        let date = sender.date
        Calendar는 identifier 필수! (왜냐면 : 나라, 종교 별로 다르기 때문에)
        let calendar = Calendar(identifier: .gregorian)
        print(calendar.dateComponents([.day], from: date))
        var dateConponents = DateComponents()
        dateConponents.day = 100
        print(calendar.date(byAdding: dateConponents, to: date)!)
        더 간결하게 쓰면 아래와 같겠지?
        */
        
        testDay(100)
        testDay(200)
        testDay(300)
        testDay(400)

    }
    func testDay(_ countInt: Int) {
        let selfFormat = DateFormatter()
        selfFormat.dateFormat = "yy년 mm월 dd일"
        
        var dateConponents = DateComponents()
        dateConponents.day = countInt
        // 근데 너무 줄이니까 다음에 봤을 때 모를 수도 있겠다
        let a = Calendar(identifier: .gregorian).date(byAdding: dateConponents, to: datePicker.date)!
        let b = selfFormat.string(from: a)
        print(b)
    }
}
