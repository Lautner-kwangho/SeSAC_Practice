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
        
//        let number: [AnyObject: String] = [NumberA: "행복해", NumberB: "사랑해", NumberC: "좋아해", NumberD: "당황해", NumberE: "속상해", NumberF: "심심해", NumberG: "행복해", NumberH: "몰라요"]
//
//
//        va
//        let
        
        let numberA = UserDefaults.standard.integer(forKey: "행복해")
        let numberB = UserDefaults.standard.integer(forKey: "사랑해")
        let numberC = UserDefaults.standard.integer(forKey: "좋아해")
        let numberD = UserDefaults.standard.integer(forKey: "당황해")
        let numberE = UserDefaults.standard.integer(forKey: "속상해")
        let numberF = UserDefaults.standard.integer(forKey: "우울해")
        let numberG = UserDefaults.standard.integer(forKey: "심심해")
        let numberH = UserDefaults.standard.integer(forKey: "행복해")
        let numberI = UserDefaults.standard.integer(forKey: "몰라요")
        
        lbl1.text = "행복해 \(numberA)"
        lbl2.text = "사랑해 \(numberB)"
        lbl3.text = "좋아해 \(numberC)"
        lbl4.text = "당황해 \(numberD)"
        lbl5.text = "속상해 \(numberE)"
        lbl6.text = "우울해 \(numberF)"
        lbl7.text = "심심해 \(numberG)"
        lbl8.text = "행복해 \(numberH)"
        lbl9.text = "몰라요 \(numberI)"
        
        // 추가 수정 예정
        view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "배경"))
    }
    
    @IBAction func deleteUsersDefault(_ sender: UIButton) {
        // 전체 삭제
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func checkingEmotion4(_ sender: UIButton) {
        let ud = UserDefaults.standard

        if btn1.isTouchInside {
            let numberA = ud.integer(forKey: "행복해")
            ud.set(numberA + 1, forKey: "행복해")
            let numberAA = ud.integer(forKey: "행복해")
            lbl1.text = "행복해 \(numberAA)"
        } else if btn2.isTouchInside {
            let numberB = ud.integer(forKey: "사랑해")
            ud.set(numberB + 1, forKey: "사랑해")
            let numberBB = ud.integer(forKey: "사랑해")
            lbl2.text = "사랑해 \(numberBB)"
        } else if btn3.isTouchInside {
            let numberC = ud.integer(forKey: "좋아해")
            ud.set(numberC + 1, forKey: "좋아해")
            let numberCC = ud.integer(forKey: "좋아해")
            lbl3.text = "좋아해 \(numberCC)"
        } else if btn4.isTouchInside {
            let numberD = ud.integer(forKey: "당황해")
            ud.set(numberD + 1, forKey: "당황해")
            let numberDD = ud.integer(forKey: "당황해")
            lbl4.text = "당황해 \(numberDD)"
        } else if btn5.isTouchInside {
            let numberE = ud.integer(forKey: "속상해")
            ud.set(numberE + 1, forKey: "속상해")
            let numberEE = ud.integer(forKey: "속상해")
            lbl5.text = "속상해 \(numberEE)"
        } else if btn6.isTouchInside {
            let numberF = ud.integer(forKey: "우울해")
            ud.set(numberF + 1, forKey: "우울해")
            let numberFF = ud.integer(forKey: "우울해")
            lbl6.text = "우울해 \(numberFF)"
        } else if btn7.isTouchInside {
            let numberG = ud.integer(forKey: "심심해")
            ud.set(numberG + 1, forKey: "심심해")
            let numberGG = ud.integer(forKey: "심심해")
            lbl7.text = "심심해 \(numberGG)"
        } else if btn8.isTouchInside {
            let numberH = ud.integer(forKey: "행복해")
            ud.set(numberH + 1, forKey: "행복해")
            let numberHH = ud.integer(forKey: "행복해")
            lbl8.text = "행복해 \(numberHH)"
        } else if btn9.isTouchInside {
            let numberI = ud.integer(forKey: "몰라요")
            ud.set(numberI + 1, forKey: "몰라요")
            let numberII = ud.integer(forKey: "몰라요")
            lbl9.text = "몰라요 \(numberII)"
        }
    }
    
}
