//
//  DrinkWaterViewController.swift
//  SeSACAssignment9
//
//  Created by 최광호 on 2021/10/10.
//

import UIKit
import SwiftUI

class DrinkWaterViewController: UIViewController {
    
    @IBOutlet var btnReload: UIBarButtonItem!
    @IBOutlet var btnGoToProfile: UIBarButtonItem!
    
    @IBOutlet var lblSubTitle1: UILabel!
    @IBOutlet var lblMainTitle: UILabel!
    @IBOutlet var lblSubTitle2: UILabel!
    
    @IBOutlet var imgMainCactus: UIImageView!
    @IBOutlet var txtHowManyWater: UITextField!
    
    @IBOutlet var lblInfoTitle: UILabel!
    @IBOutlet var btnDrink: UIButton!
    
    @IBOutlet var tabBarPlace: UIView!
    
    //함수
    var todayWater = 0
    
    var heigth = UserDefaults.standard.integer(forKey: "height")
    var weightw = UserDefaults.standard.integer(forKey: "weight")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2528861165, green: 0.5798728466, blue: 0.4502484202, alpha: 1)
        navigationItem.title = "물 마시기"
        navigationController?.navigationBar.tintColor = .white
        
        //layout
        // Bar Item & 물마시기 버튼
        barBtnSetting(btnReload, systemImageName: "arrow.clockwise")
        barBtnSetting(btnGoToProfile, systemImageName: "person.circle")
        setBtnItem()
        // Label
        setTxtTitle(lblSubTitle1, text: "잘하셨어요! \n오늘 마신 양은", fontSize: 25)
        setTxtTitle(lblMainTitle, text: "00ml", fontSize: 30)
        setTxtTitle(lblSubTitle2, text: "목표의 00%", fontSize: 15)
        setLayoutText()
        // Middle Image & textField
        setImageCactus()
        setTextfield()
        
        // tabBar가 오면 들어갈 자리라서 하얀색 배경을 집어 넣어봤습니다!
        tabBarPlace.backgroundColor = .white
        
        let myWater = UserDefaults.standard.integer(forKey: "myWater")
        lblMainTitle.text = "\(myWater) ml"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lblInfoTitle.textColor = .white
        lblInfoTitle.font = UIFont.systemFont(ofSize: 14)
        if UserDefaults.standard.string(forKey: "nickname") == nil {
            lblInfoTitle.text = "안녕하세요 profile을 입력해주세요"
        } else {
            let heigth = UserDefaults.standard.integer(forKey: "height")
            let weightw = UserDefaults.standard.integer(forKey: "weight")
            let myWater: Double = Double((heigth + weightw)) * 0.01
            let myWaterFomat = String(format: "%.1f", myWater)
            lblInfoTitle.text = "안녕하세요 \(UserDefaults.standard.string(forKey: "nickname")!)님의 하루 물 권장 섭취량은 \(myWaterFomat)L입니다."
        }
    }
    
    func barBtnSetting(_ btn: UIBarButtonItem, systemImageName: String) {
        btn.image = UIImage(systemName: systemImageName)
        btn.tintColor = .white
    }
    
    func setBtnItem() {
        // Bar Item 버튼
        btnReload.setBackgroundImage(UIImage(named: "reload"), for: .normal, barMetrics: .default)
        
        // 물마시기 버튼
        btnDrink.tintColor = .black
        btnDrink.backgroundColor = .white
        btnDrink.setTitle("물마시기", for: .normal)
    }
    
    func setTxtTitle(_ lbl: UILabel, text: String, fontSize: Int) {
        lbl.textColor = .white
        lbl.text = text
        lbl.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
    
    func setLayoutText() {
        lblSubTitle1.numberOfLines = 0
        lblSubTitle1.adjustsFontSizeToFitWidth = true
        lblMainTitle.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    func setImageCactus() {
        imgMainCactus.image = UIImage(named: "1-1")
        imgMainCactus.backgroundColor = #colorLiteral(red: 0.2528861165, green: 0.5798728466, blue: 0.4502484202, alpha: 1)
        imgMainCactus.layer.cornerRadius = imgMainCactus.frame.size.height / 2
    }
    
    func setTextfield() {
        let txt = txtHowManyWater
        txt?.placeholder = "⭐️얼마나 마셨어요?!?⭐️"
        txt?.keyboardType = .numberPad
        txt?.backgroundColor = .clear
        txt?.textColor = .white
        txt?.textAlignment = .center
        txt?.font = UIFont.boldSystemFont(ofSize: 40)
    }
    
    
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func endEnterEditing(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    @IBAction func deleteUserDefaults(_ sender: UIBarButtonItem) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        lblMainTitle.text = "00 ml"
        lblSubTitle2.text = "목표의 00%"
        todayWater = 0
        txtHowManyWater.text = ""
    }
    
    @IBAction func ClickedDrinkWater(_ sender: UIButton) {
        let drink = txtHowManyWater.text!
        
        todayWater = todayWater + Int(drink)!
        
        if todayWater <= 999, todayWater >= 500 {
            lblMainTitle.textColor = .gray
            imgMainCactus.image = UIImage(named: "1-3")
        } else if todayWater <= 1500, todayWater >= 1000 {
            lblMainTitle.textColor = .blue
            imgMainCactus.image = UIImage(named: "1-6")
        } else if todayWater <= 2000, todayWater >= 1501 {
            lblMainTitle.textColor = .red
            imgMainCactus.image = UIImage(named: "1-9")
        }
        
        lblMainTitle.text = "\(todayWater) ml"
    
        let todayGoal: Double = Double((heigth + weightw)) * 0.01
        let todayWater: Double = Double(todayWater) * 0.001
        let goal = 100 - ((todayGoal - todayWater) / todayGoal * 100)
        let formatGoal = String(format: "%.0f", goal)
        
        if formatGoal == "%.0f" {
            lblSubTitle2.text = "목표의 0%"
        } else {
            lblSubTitle2.text = "목표의 \(formatGoal) %"
        }
        
        UserDefaults.standard.set(todayWater, forKey: "myWater")
    }
    

}

