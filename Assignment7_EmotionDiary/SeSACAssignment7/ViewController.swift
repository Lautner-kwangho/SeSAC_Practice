//
//  ViewController.swift
//  SeSACAssignment7
//
//  Created by 최광호 on 2021/10/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var lbl3: UILabel!
    @IBOutlet var lbl4: UILabel!
    @IBOutlet var lbl5: UILabel!
    @IBOutlet var lbl6: UILabel!
    @IBOutlet var lbl7: UILabel!
    @IBOutlet var lbl8: UILabel!
    @IBOutlet var lbl9: UILabel!

    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    @IBOutlet var btn6: UIButton!
    @IBOutlet var btn7: UIButton!
    @IBOutlet var btn8: UIButton!
    @IBOutlet var btn9: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initNumber = UserDefaults.standard.integer(forKey: "initNumber")
        lbl1.text = "행복해 \(initNumber)"
        
        let TwoNumber = UserDefaults.standard.integer(forKey: "2Number")
        lbl2.text = "사랑해 \(TwoNumber)"
        
        let ThreeNumber = UserDefaults.standard.integer(forKey: "3Number")
        lbl3.text = "좋아해 \(ThreeNumber)"
        
        lbl4.text = "속상해"
        lbl5.text = "우울해"
        lbl6.text = "아이고"
        lbl7.text = "조금만"
        lbl8.text = "더더더"
        lbl9.text = "생각해"
    
        
//
//        let emotionCounting = [1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"]
//
//
//        for (key: value) in emotionCounting {
//            print("\(value)")
//        }
    }

    @IBAction func checkingEmotion1(_ sender: UIButton) {
        let initNumber = UserDefaults.standard.integer(forKey: "initNumber")
        UserDefaults.standard.set(initNumber + 1, forKey: "initNumber")
        
        let updateNumber = UserDefaults.standard.integer(forKey: "initNumber")
        lbl1.text = "행복해 \(updateNumber)"
        
//        let emotionCounting: [UIButton: String] = [btn1: "One", btn2: "Two", btn3: "Three", btn4: "Four", btn5: "Five", btn6: "Six", btn7: "Seven", btn8: "Eight", btn9: "Nine"]
//
//        for (UIButton, String) in emotionCounting {
//            let iNumber = UserDefaults.standard.integer(forKey: "\(String)")
//            UserDefaults.standard.set(iNumber + 1, forKey: "\(String)")
//            let uNumber = UserDefaults.standard.integer(forKey: "\(String)")
//            lbl2.text = "행복해 \(updateNumber)"
    }
    
    @IBAction func checkingEmotion2(_ sender: UIButton) {
        // 이렇게 노가다는 아닌 듯...
        let twoNumber = UserDefaults.standard.integer(forKey: "2Number")
        UserDefaults.standard.set(twoNumber + 1, forKey: "2Number")
        
        let u2Number = UserDefaults.standard.integer(forKey: "2Number")
        lbl2.text = "사랑해 \(u2Number)"
    }
    
    @IBAction func checkingEmotion3(_ sender: UIButton) {
        // 아 정말 이건 아닌 듯 ...
        // 오기 생겨서 혼자 한다 ...
        let threeNumber = UserDefaults.standard.integer(forKey: "3Number")
        UserDefaults.standard.set(threeNumber + 1, forKey: "3Number")
        
        let u3Number = UserDefaults.standard.integer(forKey: "3Number")
        lbl3.text = "좋아해 \(u3Number)"
    }
    
    
}
    
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        // 출첵
        let number = UserDefaults.standard.integer(forKey: "number")
        numberlbl.text = "\(number)"
    }
    
    // 출첵 2 - 출석체크 버튼 누를 때의 기능
    // 10번 출첵 -> 3번 누르면 -> 13번 저장
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        // 출첵 3 - 기존 출첵된 숫자 가져오기 (10번)
        let number = UserDefaults.standard.integer(forKey: "number")
        
        // 출첵 4 - 기존 출첵된 숫자에서 1을 더한 값을 새롭게 number 키에 저장
        UserDefaults.standard.set(number + 1, forKey: "number")
        
        // 출첵 5 - lbl에 보여지고 있는 값 업데이트
        let updateNumber = UserDefaults.standard.integer(forKey: "number")
        numberlbl.text = "\(updateNumber)"
    }
     */

    

