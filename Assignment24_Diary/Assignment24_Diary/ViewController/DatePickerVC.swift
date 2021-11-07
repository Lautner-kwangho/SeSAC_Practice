//
//  DatePickerVC.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/07.
//

import UIKit

protocol ProtocolData {
    func protocolData(date: String)
}

class DatePickerVC: UIViewController {

    static let identifier = "DatePickerVC"
    var date = "날짜를 입력해주세요"
    var delegate: ProtocolData?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = datePicker.frame.size.height * 0.2
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        let value = DateFormatter.customFormatter.string(from: datePicker.date)
        date = value
        self.delegate?.protocolData(date: date)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
