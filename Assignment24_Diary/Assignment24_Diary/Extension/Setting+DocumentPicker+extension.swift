//
//  Setting+DocumentPicker+extension.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/07.
//

import UIKit
import Zip
import MobileCoreServices

extension SettingVC: UIDocumentPickerDelegate {
//    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//        alert(title: "취소", message: "백업이 취소되었습니다", actionTitle: "확인")
//    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectFileURL = urls.first else {return}
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandBoxFileURL = directory.appendingPathComponent(selectFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandBoxFileURL.path) {
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                // 흠.. 정규화를 어떻게 할ㄱ...
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
//                print(documentDirectory)
//                print(fileURL)
//                try! Zip.quickUnzipFile(documentDirectory)
                try! Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    self.alert(title: "복구 완료", message: "정상적이 사용을 위해 재시작해야합니다", actionTitle: "확인")
                }, fileOutputHandler: { unzippedFile in
                    self.alert(title: "unzipFile", message: "\(unzippedFile)", actionTitle: "확인")
                })
            } catch {
                self.alert(title: "오류", message: "오류입니다", actionTitle: "확인")
            }
        } else {
            // document folder 복사
            do {
                try FileManager.default.copyItem(at: selectFileURL, to: sandBoxFileURL)
//                self.alert(title: "다시 눌러주세요", message: "폴더를 복사 중입니다 복구 버튼을 한번 더 눌러주세요", actionTitle: "확인")
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                try! Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("\(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("\(unzippedFile)")
                })
            } catch {
                self.alert(title: "오류", message: "오류입니다", actionTitle: "확인")
            }
        }
    }
}
