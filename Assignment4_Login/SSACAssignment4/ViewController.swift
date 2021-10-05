//
//  ViewController.swift
//  SSACAssignment4
//
//  Created by 최광호 on 2021/09/30.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var txt1: UITextField!
    @IBOutlet var txt2: UITextField!
    @IBOutlet var txt3: UITextField!
    @IBOutlet var txt4: UITextField!
    @IBOutlet var txt5: UITextField!
    
    @IBOutlet var btn1: UIButton!
    
    @IBOutlet var lblAddInfo: UILabel!
    @IBOutlet var switchMode: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSetting(txt3)
        lblAddInfo.text = "추가 정보 입력"
        swSetting()
    }
    
    func txtSetting(_ txt: UITextField) {
        // placeholder, keyboard 등 같은 경우 아래처럼 쓰면 됨, 근데 코드 줄이려고 주석 달아놓음
        // txt.placeholder? = "값을 입력해주세요"
        // txt.keyboardType = .URL
        // txt.isSecureTextEntry = true
        txt.textColor = .white
        txt.textAlignment = .center
        txt.borderStyle = .none
        txt.backgroundColor = .systemGray2
    }
    
    func swSetting() {
        switchMode.setOn(true, animated: true)
        switchMode.isOn = true
        switchMode.onTintColor = .red
        switchMode.thumbTintColor = .white
    }
    
    @IBAction func passwordYN(_ sender: UITextField) {
        let password = NSPredicate(format: "SELF MATCHES %@ ", "^.{6,}$")
        let yesOrNo = password.evaluate(with: txt2.text)
        
        if yesOrNo == false {
            let alert = UIAlertController(title: "비밀번호 오류", message: "비밀번호를 6자리 이상입력해주세요", preferredStyle: UIAlertController.Style.alert)
            let okAction =  UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
            
            alert.addAction(okAction)
            self.present(alert, animated: false)
            txt2.text = ""
        }
    }
    @IBAction func btnSignUp(_ sender: UIButton) {

        if txt1.text != "" && txt2.text != "" {
            print("회원가입 정보 확인\n ID: \(txt1.text!)")
            print("PW: \(txt2.text!)")
            print("Nick: \(txt3.text ?? "닉네임")")
            print("LOCATION: \(txt4.text ?? "지역")")
            print("CODE: \(txt5.text ?? "코드")")
            
            let alert = UIAlertController(title: "회원가입 완료", message: "환영합니다 \(txt3.text ?? "")회원님", preferredStyle: UIAlertController.Style.alert)
            let okAction =  UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
            
            alert.addAction(okAction)
            self.present(alert, animated: false)
            
        } else {
            let alert = UIAlertController(title: "회원가입 실패", message: "값을 다시 입력해주세요", preferredStyle: UIAlertController.Style.alert)
            let okAction =  UIAlertAction(title: "네 ㅜㅜ", style: UIAlertAction.Style.default)
            
            alert.addAction(okAction)
            self.present(alert, animated: false)
        }

        view.endEditing(true)

    }
    
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func endEditing2(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    @IBAction func swOn(_ sender: UISwitch) {
        if switchMode.isOn == false {
            txt3.isHidden = true
            txt4.isHidden = true
            txt5.isHidden = true
        } else {
            txt3.isHidden = false
            txt4.isHidden = false
            txt5.isHidden = false
        }
    }
    
}

