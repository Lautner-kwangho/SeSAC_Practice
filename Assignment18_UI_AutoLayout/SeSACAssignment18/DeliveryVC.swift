//
//  DeliveryVC.swift
//  SeSACAssignment18
//
//  Created by 최광호 on 2021/10/22.
//

import UIKit

class DeliveryVC: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var viewImage8: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewImage8.clipsToBounds = true
        viewImage8.layer.cornerRadius = viewImage8.frame.height / 10
        let viewArray = [view1, view2, view3,view4, view5, view6, view7]
        viewArray.forEach { myView in
            if let myview = myView {
                border(myview)
            }
        }
//      tag 나 클로저 구문
//        for i in 1...8 {
//            if let myview = view.viewWithTag(i) {
//                border(myview)
//            }
//        }
    }
    
    @IBAction func popButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func border(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.height * 0.1
    }

}
