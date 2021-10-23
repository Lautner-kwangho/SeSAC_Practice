//
//  KakaoVC.swift
//  SeSACAssignment18
//
//  Created by 최광호 on 2021/10/22.
//

import UIKit

class KakaoVC: UIViewController {

    @IBOutlet weak var myProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myProfileImage.layer.cornerRadius = myProfileImage.frame.height / 2.5
        myProfileImage.backgroundColor = .white
        myProfileImage.image = UIImage(named: "bob-minions")
        // 여기 부분 떄문에 버벅거리는 듯
        view.backgroundColor = UIColor(patternImage: UIImage(named: "W")!).withAlphaComponent(0.5)
    }

    @IBAction func popButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
}
