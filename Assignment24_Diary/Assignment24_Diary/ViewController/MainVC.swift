//
//  ViewController.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var goToMyDiary: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //여기서 navigation으로 push하니까 뒤에서 navigation item을 마음대로 못 사용해서 presentModally 에 fullScreem에 animate 없애버림
        goToMyDiary.titleLabel?.textAlignment = .center
    }
    
}

