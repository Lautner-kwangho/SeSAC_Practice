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
            return directoryPath
        } else {
            return nil
        }
    }
    
    @IBAction func backupButton(_ sender: UIButton) {
        var urlPaths = [URL]()
        if let path = documentDirectoryPath() {
            let realm = (path as NSString).appendingPathComponent("*.realm")
            if FileManager.default.fileExists(atPath: realm) {
                urlPaths.append(URL(string: realm)!)
                print(urlPaths.append(URL(string: realm)!))
            } else {
                print("백업할 파일이 없습니다")
            }
        }
    }
    

    @IBAction func restoreButton(_ sender: UIButton) {
    }
}
