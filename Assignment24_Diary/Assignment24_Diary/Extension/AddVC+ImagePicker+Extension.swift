//
//  AddVC+ImagePicker+Extension.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit
import PhotosUI

extension AddVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // ?? PHpicker WWDC 2020 참고 (단, iOS 14 이상 부터)
        
        if let value = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            addImage.image = value
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
