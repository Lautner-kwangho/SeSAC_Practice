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
        
        placeholder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTextField.delegate = self
        print(localRealm.configuration.fileURL!)
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
        if addTitle.text == "" || addTextField.text == "" {
            alert(title: "입력해주세요", message: "내용을 입력해주세요", actionTitle: "확인")
        } else {
            let task = DiaryRealm(diaryTitle: "\(addTitle.text!)", diaryContent: "\(addTextField.text!)", diaryDate: addDate.currentTitle!, diaryRegister: Date())
            try! localRealm.write {
                localRealm.add(task)
                saveImageToDocumentDirectory(imageName: "\(task._id)", image: addImage.image!)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // 이미지 저장
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        guard let data = image.jpegData(compressionQuality: 0.5) else {return}
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            do {
                try FileManager.default.removeItem(at: imageURL)
                alert(title: "중복 제거", message: "삭제되었습니다", actionTitle: "확인")
            } catch {
                alert(title: "에러", message: "사진을 삭제하지 못하였습니다", actionTitle: "확인")
            }
        }
        
        do {
            try data.write(to: imageURL)
        } catch {
            alert(title: "에러", message: "사진을 저장하지 못하였습니다", actionTitle: "확인")
        }
    }
    
    func outletSetting() {
        addImage.backgroundColor = .clear
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
