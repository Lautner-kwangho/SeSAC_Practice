//
//  ViewController.swift
//  SSACAssignment5_2
//
//  Created by 최광호 on 2021/10/03.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var textFieldInput: UITextField!
    
    @IBOutlet var btnTagFirst: UIButton!
    @IBOutlet var btnTagSecond: UIButton!
    @IBOutlet var btnTagThird: UIButton!
    @IBOutlet var btnTagFourth: UIButton!
    
    @IBOutlet var resultLabel: UILabel!
    
    var newlyCoinedWord: Dictionary = ["꾸안꾸": ["꾸민듯 안 꾸민듯", "꾸꾸", "까까", "안안", "듯듯"], "JMT": ["좀 많이 맛있다!", "존맛", "맛집", "꿀맛", "허니맛"], "팩력배": ["팩트 + 폭력배", "무섭", "삥뜯ㅠ", "아픔", "슬픔"], "슬세권": ["슬리퍼와 O세권", "맥도날드", "편의점", "슈퍼", "올영"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnInit(btn: btnTagFirst)
        btnInit(btn: btnTagSecond)
        btnInit(btn: btnTagThird)
        btnInit(btn: btnTagFourth)
    }
    
    func btnInit(btn: UIButton) {
//        btn.setTitle("", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
    }
    
    @IBAction func endEditing(_ sender: UITextField) {
        view.endEditing(true)
    }
    @IBAction func searchBtn(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "값이 없는뎅?", message: "입력하세요!", preferredStyle: UIAlertController.Style.alert)

        if view.endEditing(true) == false {
            view.endEditing(true)
        } else if resultLabel.text == " " {
            // 이런식으로 하면 됨
            present(alert, animated: false)
        } else {
            let sortedDic = newlyCoinedWord[textFieldInput.text ?? "입력된 값이 아니에요 ㅠㅠ"]
            resultLabel.text = sortedDic?[0] ?? "입력없엉 ㅜ"
            
            btnTagFirst.setTitle(sortedDic?[1], for: .normal)
            btnTagSecond.setTitle(sortedDic?[2], for: .normal)
            btnTagThird.setTitle(sortedDic?[3], for: .normal)
            btnTagFourth.setTitle(sortedDic?[4], for: .normal)
        }

    }
    @IBAction func endEditingTab(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

