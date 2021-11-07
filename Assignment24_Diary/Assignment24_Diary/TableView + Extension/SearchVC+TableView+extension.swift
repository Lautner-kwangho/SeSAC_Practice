//
//  SearchVC+TableView+extension.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nibName = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        SearchTableView.register(nibName, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        guard let cell = SearchTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else { return UITableViewCell() }
        
        let row = tasks[indexPath.row]
        
        cell.searchImage.backgroundColor = .clear
        cell.searchTitle.text = row.diaryTitle
        cell.SearchDate.text = "\(row.diaryDate)"
        cell.searchContent.text = row.diaryContent
        cell.searchImage.image = loadImageFromDocumentDirectory(imageName: "\(row._id).jpg")
    
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: EditVC.identifier) as? EditVC else {return}
        vc.modalTransitionStyle = .coverVertical
        vc.editTasks = tasks[indexPath.row]
        present(vc, animated: true)
    }
    // 이미지 로드
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let directoryPath = path.first {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let row = tasks[indexPath.row]
        try! localRealm.write {
            deleteImageFromDocumentDirectory(imageName: "\(row._id).jpg")
            localRealm.delete(row)
            tableView.reloadData()
        }
    }
    
    // DocumentImageDelete
    func deleteImageFromDocumentDirectory(imageName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            do {
                try FileManager.default.removeItem(at: imageURL)
            } catch {
                alert(title: "오류", message: "디바이스에서 사진을 삭제하지 못 했습니다", actionTitle: "확인")
            }
        }
    }
        
}
