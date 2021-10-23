//
//  ViewController.swift
//  SeSACAssignment18
//
//  Created by 최광호 on 2021/10/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

}

extension UIViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        return true
    }
}
