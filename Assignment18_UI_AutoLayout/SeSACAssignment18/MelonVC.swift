//
//  MelonVC.swift
//  SeSACAssignment18
//
//  Created by 최광호 on 2021/10/22.
//

import UIKit

class MelonVC: UIViewController {
    
    @IBOutlet weak var albumImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        albumImage.image = UIImage(named: "albumImage")
        albumImage.backgroundColor = .clear
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    @IBAction func popButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    

}
