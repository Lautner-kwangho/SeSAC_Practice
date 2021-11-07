//
//  SettingVC.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit
import Zip
import MobileCoreServices

class SettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        documentDirectoryPath()
    }
    
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let directoryPath = path.first {
            print(directoryPath)
            return directoryPath
        } else {
            return nil
        }
    }
    
    func presentActivityViewController() {
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backupButton(_ sender: UIButton) {
        var urlPaths = [URL]()
        if let path = documentDirectoryPath() {
            let realm = (path as NSString).appendingPathComponent("default.realm")
            if FileManager.default.fileExists(atPath: realm) {
                urlPaths.append(URL(string: realm)!)
                print(urlPaths.append(URL(string: realm)!))
            } else {
                alert(title: "백업 파일 없음", message: "백업할 파일이 없습니다", actionTitle: "확인")
            }
        }
        // 압축 파일 만들기 (라이브러리)
        do {
//            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "\(DateFormatter.customFormatter.string(from: Date()))")
// 폴더 만들어서 하는 건 시간이 되면.. (사진도 같이 옮겨야하는데 지금은 realm파일만 가져오니까 폴더를 만들고 폴더를 압축하는 형식으로)
            try Zip.quickZipFiles(urlPaths, fileName: "archive")
            presentActivityViewController()
        } catch {
            alert(title: "접근 불가", message: "잘못된 접근입니다", actionTitle: "확인")
        }
    }
    

    @IBAction func restoreButton(_ sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
}
