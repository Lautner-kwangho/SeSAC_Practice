//
//  LinkedViewController.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/18.
//

import UIKit

class LinkedVC: UIViewController {
    static let identifier = "LinkedVC"
    
    // 1. Pass
    var linkedTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // 2. Pass
        title = linkedTitle ?? "되나?"
    }
    
}
