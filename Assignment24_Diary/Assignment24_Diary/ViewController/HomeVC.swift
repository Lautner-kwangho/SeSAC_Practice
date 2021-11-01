//
//  HomeVC.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarSetting()
    }
    
    func navigationBarSetting() {
        self.title = LocalizationString.HomeVC_Title.localized
        
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(goToAdd))
        navigationItem.rightBarButtonItem = plusButton
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func goToAdd() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: AddVC.identifier) as! AddVC
        let navi = UINavigationController(rootViewController: vc)
        
        navi.modalPresentationStyle = .fullScreen
        
        self.present(navi, animated: true, completion: nil)
    }

}
