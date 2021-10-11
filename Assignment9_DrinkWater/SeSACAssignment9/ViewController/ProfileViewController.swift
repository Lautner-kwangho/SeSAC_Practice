//
//  ProfileViewController.swift
//  SeSACAssignment9
//
//  Created by 최광호 on 2021/10/10.
//

import UIKit
import TextFieldEffects

class ProfileViewController: UIViewController {

    @IBOutlet var btnSave: UIBarButtonItem!
    
    @IBOutlet var txtFieldNickname: HoshiTextField!
    @IBOutlet var txtFieldHeight: HoshiTextField!
    @IBOutlet var txtFieldWeight: HoshiTextField!
    
    @IBOutlet var imgSubCactus: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2528861165, green: 0.5798728466, blue: 0.4502484202, alpha: 1)
        
        setBtnMyProfileItem()
        setImageMyProfile()
        setMyTxtField(txtFieldNickname, textPlacement: "닉넴임을", keyboardType: .default)
        setMyTxtField(txtFieldHeight, textPlacement: "키(cm)를", keyboardType: .numberPad)
        setMyTxtField(txtFieldWeight, textPlacement: "몸무게(kg)를", keyboardType: .numberPad)
        
        let userNickname = UserDefaults.standard.string(forKey: "nickname")
        txtFieldNickname.text = userNickname
        let userHeight = UserDefaults.standard.string(forKey: "height")
        txtFieldHeight.text = userHeight
        let userWeight = UserDefaults.standard.string(forKey: "weight")
        txtFieldWeight.text = userWeight
    }
    
    func setBtnMyProfileItem() {
        btnSave.title = "저장"
    }
    
    func setImageMyProfile() {
        imgSubCactus.image = UIImage(named: "1-1")
        imgSubCactus.layer.cornerRadius = imgSubCactus.frame.height / 2
        
    }
    
    func setMyTxtField(_ txt: HoshiTextField, textPlacement: String, keyboardType: UIKeyboardType) {
        txt.placeholder = "\(textPlacement) 설정해주세요"
        txt.placeholderColor = .white
        txt.backgroundColor = .clear
        txt.borderActiveColor = .white
        txt.textColor = .white
        txt.borderInactiveColor = .white
        txt.keyboardType = keyboardType
        txt.layer.borderWidth = 0.5
        txt.layer.borderColor = #colorLiteral(red: 0.2528861165, green: 0.5798728466, blue: 0.4502484202, alpha: 1).cgColor
    }
    
    @IBAction func saveUserDefaults(_ sender: UIButton) {
        
        let userNickname = txtFieldNickname.text ?? "ㅜㅜ"
        UserDefaults.standard.set(userNickname, forKey: "nickname")
        let userHeight = txtFieldHeight.text ?? "160"
        UserDefaults.standard.set(userHeight, forKey: "height")
        let userWeight = txtFieldWeight.text ?? "50"
        UserDefaults.standard.set(userWeight, forKey: "weight")
    }
    
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func endEditing2(_ sender: UITextField) {
        view.endEditing(true)
    }
}
