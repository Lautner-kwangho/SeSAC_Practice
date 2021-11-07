//
//  AddVC.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit
import RealmSwift

class AddVC: UIViewController, ProtocolData {
    func protocolData(date: String) {
        addDate.setTitle(date, for: .normal)
    }

    static let identifier = "AddVC"
    
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var addTitle: UITextField!
    @IBOutlet weak var addDate: UIButton!
    @IBOutlet weak var addTextField: UITextView!
    
    let localRealm = try! Realm()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        navigationItemSetting()
        
        outletSetting()
    }
    
    func navigationItemSetting() {
        navigationItem.title = LocalizationString.AddVC_Title.localized
        
        let cancelButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(goToBack))
        self.navigationItem.leftBarButtonItem = cancelButton
        cancelButton.tintColor = .black
        
        let saveButton = UIBarButtonItem(title: LocalizationString.AddVC_SaveButton_Title.localized, style: .plain, target: self, action: #selector(dataSave))
        self.navigationItem.rightBarButtonItem = saveButton
        saveButton.tintColor = .black
        
    }
    
    @objc func goToBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dataSave() {
        let task = DiaryRealm(diaryTitle: "\(addTitle.text!)", diaryContent: "\(addTextField.text!)", diaryDate: Date(), diaryRegister: Date())
        try! localRealm.write {
            localRealm.add(task)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func outletSetting() {
        addImage.backgroundColor = .systemGray3
        addImage.image = UIImage(systemName: "shareplay")
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(openPicture))
        addImage.addGestureRecognizer(longGesture)
        addImage.isUserInteractionEnabled = true
        
        addTitle.backgroundColor = .systemGray3
        addTitle.placeholder = LocalizationString.AddVC_AddTitle_Placeholder.localized
        addTitle.textAlignment = .center
        
        addDate.backgroundColor = .systemGray3
        addDate.addTarget(self, action: #selector(selectDatePicker), for: .touchUpInside)
        addDate.setTitle("\(DateFormatter.customFormatter.string(from: Date()))", for: .normal)
        
        addTextField.backgroundColor = .systemGray3
        addTextField.font = UIFont().mainFont
    }
    
    @objc func selectDatePicker() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: DatePickerVC.identifier) as? DatePickerVC else {return}
        vc.modalTransitionStyle = .coverVertical
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    
    @objc func openPicture() {
        self.present(imagePicker, animated: true, completion: nil)
    }

}
