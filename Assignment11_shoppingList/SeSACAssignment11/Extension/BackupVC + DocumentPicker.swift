//
//  BackupVC + DocumentPicker.swift
//  SeSACAssignment11
//
//  Created by 최광호 on 2021/11/06.
//

import UIKit
import MobileCoreServices
import Zip

extension BackupViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        let alert = UIAlertController(title: "Cancel Backup", message: "취소되었습니다", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {return}
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sanboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sanboxFileURL.path) {
            // 압축해제
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                try! Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("\(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("\(unzippedFile)")
                })
            } catch {
                print("error")
            }
        } else {
            // 폴더에 복사
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sanboxFileURL)
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                try! Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    // 일단 기본부터 해놓고 수정하는 걸로
                    let alert = UIAlertController(title: "복구를 완료하기 위해", message: "\(progress)완료 앱을 재실행합니다", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    print("\(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("\(unzippedFile)")
                })
            } catch {
                print("Error")
            }
        }
    }
}
