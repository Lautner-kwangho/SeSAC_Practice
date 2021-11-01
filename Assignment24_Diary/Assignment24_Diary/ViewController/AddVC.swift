//
//  AddVC.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit

class AddVC: UIViewController {

    static let identifier = "AddVC"
    
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var addTitle: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addTextField: UITextView!
    
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
        
        addButton.backgroundColor = .systemGray3
        let dateFomatter = DateFormatter()
        dateFomatter.locale = Locale(identifier: "ko_KR")
        dateFomatter.dateFormat = LocalizationString.AddVC_SaveButton_DateFormat.localized
        addButton.setTitle("\(dateFomatter.string(from: Date()))", for: .normal)
        
        addTextField.backgroundColor = .systemGray3
        addTextField.font = UIFont().mainFont
    }
    
    @objc func openPicture() {
        self.present(imagePicker, animated: true, completion: nil)
    }

}
