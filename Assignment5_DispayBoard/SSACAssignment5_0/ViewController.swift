//
//  ViewController.swift
//  SSACAssignment5_1
//
//  Created by 최광호 on 2021/10/03.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var highView: UIView!
    @IBOutlet var btnSend: UIButton!
    @IBOutlet var btnColorChange: UIButton!
    
    @IBOutlet var txtField: UITextField!
    @IBOutlet var textView: UILabel!
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        highViewSetting()
        btnSetting(btnSend)
        btnSetting(btnColorChange)
        txtField.textColor = .black
        
        textSetting(content: "뭐가 들어갈까요?")
    }
    func highViewSetting() {
        highView.layer.cornerRadius = 20
        highView.backgroundColor = .white
    }
    
    func btnSetting(_ btnName: UIButton) {
        btnName.layer.cornerRadius = 10
        btnName.layer.borderWidth = 2
        btnName.layer.borderColor = UIColor.black.cgColor
    }
    
    func textSetting(content: String) {
        textView.text = content
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.adjustsFontSizeToFitWidth = true
    }

    @IBAction func sendToLabel(_ sender: UIButton) {
        textView.text = txtField.text
        txtField.text = ""
    }
    
    @IBAction func changLabel(_ sender: UIButton) {
        let r : CGFloat = CGFloat.random(in: 0...1)
        let g : CGFloat = CGFloat.random(in: 0...1)
        let b : CGFloat = CGFloat.random(in: 0...1)
        // alpha : 0...1 투명도 설정
        textView.textColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    @IBAction func endEditing(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    @IBAction func hiddenView(_ sender: UITapGestureRecognizer) {

        view.endEditing(true)

        let hidden = highView.isHidden == false ? true : false
        
        highView.isHidden = hidden
    }
    
}

