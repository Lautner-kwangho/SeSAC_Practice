//
//  ViewController.swift
//  SeSACAssignment19
//
//  Created by 최광호 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var lbl7: UILabel!
    
    @IBOutlet weak var drawRound: UILabel!
    @IBOutlet weak var drawDay: UILabel!
    var drawData: [String] = []
    
    var drawCount = 0
    
    var numberIndex: Array<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDate()
        
        let selfPicker = UIPickerView()
        selfPicker.delegate = self
        selfPicker.dataSource = self

        textField.inputView = selfPicker
        
        lblSet()
        
        urlSet()
    }
    
    func setDate() {
        var component = Calendar.current.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday],from: Date())
        component.weekday = 7
            
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-dd"
        
        // 만약 내가 처음 창조? 만드는? 시점이면 이렇게 하는 게 좋을 거 같음? 아닌가 ㅎㅎ;
        guard let date = Calendar.current.date(from: component) else {return}
        // 로또가 처음 시작한 날!
        guard let mainDate = dateFomatter.date(from: "2002-12-07") else {return}
        
        let initRound = Calendar.current.dateComponents([.weekOfYear], from: mainDate, to: date)
        
        if let round = initRound.weekOfYear {
            drawCount = round
        }
    }
    
    func lblSet() {
        let labelArray = [lbl1, lbl2, lbl3, lbl4, lbl5, lbl6, lbl7]
        for labelArray in labelArray {
            labelSet(labelArray!)
        }
    }
    
    func urlSet() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drawCount)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let name = ["drwtNo1", "drwtNo2", "drwtNo3", "drwtNo4", "drwtNo5", "drwtNo6", "bnusNo", "drwNo", "drwNoDate"]

                for a in name {
                    let array = json[a].stringValue
                    self.drawData.append(array)
                }
                
                self.lbl1.text = self.drawData[0]
                self.lbl2.text = self.drawData[1]
                self.lbl3.text = self.drawData[2]
                self.lbl4.text = self.drawData[3]
                self.lbl5.text = self.drawData[4]
                self.lbl6.text = self.drawData[5]
                self.lbl7.text = self.drawData[6]
                self.drawRound.text = "\(self.drawData[7]) 회차"
                self.drawDay.text = self.drawData[8]
            case .failure(let error):
                print(error)
            }
        }

    }
    func labelSet(_ lbl: UILabel) {
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = lbl.frame.size.height / 2
        lbl.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 0.6)
    }

    
    @IBAction func EndEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let number = Int(drawData[7]) else { return 100 }
        return number
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = "\(numberIndex[row]) 회"
        
        // 여기서 데이터 갱신할 거 같은데 흠.. 일단 급한대로 ㅋㅋ..
        drawCount = numberIndex[row]
        self.drawData.removeAll()
        urlSet()
        lblSet()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        numberIndex.append(contentsOf: stride(from: Int(drawData[7]) ?? 100, to: 1, by: -1))
        return "\(numberIndex[row]) 회"
    }
    
}
