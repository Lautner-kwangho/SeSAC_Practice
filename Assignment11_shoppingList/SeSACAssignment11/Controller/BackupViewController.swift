//
//  BackupViewController.swift
//  SeSACAssignment11
//
//  Created by 최광호 on 2021/11/05.
//

import UIKit
import Zip
import MobileCoreServices

class BackupViewController: UIViewController {

    static let identifier = "BackupViewController"
    
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var backupButton: UIButton!
    @IBOutlet weak var rollbackButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = #colorLiteral(red: 0.5414963365, green: 0.7096383572, blue: 0.7032404542, alpha: 1)
        backupButton.backgroundColor = #colorLiteral(red: 0.3123301864, green: 0.462901473, blue: 0.6003618836, alpha: 1)
        backupButton.titleLabel?.textColor = .white
        rollbackButton.backgroundColor = #colorLiteral(red: 0.3123301864, green: 0.462901473, blue: 0.6003618836, alpha: 1)
        rollbackButton.titleLabel?.textColor = .white
        documentDirectoryPath()
    }
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true , completion: nil)
    }
    // 다 extension 해서 중복 줄일 수도
    // 1. document 위치 확인
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
    // ActivityViewController - 공유 버튼을 누르면 밑에서 팝업 창 뜨는 거
    func presentActivityViewController() {
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
    }
    // 백업
    @IBAction func backupAction(_ sender: UIButton) {
        var urlPath = [URL]()
        if let path = documentDirectoryPath() {
            let realm = (path as NSString).appendingPathComponent("default.realm")
            if FileManager.default.fileExists(atPath: realm) {
                urlPath.append(URL(string: realm)!)
            } else {
                // 알림 같은 걸 올릴 수도 있을 거 같음
                print("백업할 파일이 없습니다.")
            }
        }
        // 압축 파일 만들기 (라이브러리 사용)
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPath, fileName: "archive", progress: { progress in
                print(progress)
            })
            presentActivityViewController()
            print(zipFilePath)
        } catch {
            print("something went wrong")
        }
        
    }
    
    // 복구
    @IBAction func rollbackAction(_ sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
}
