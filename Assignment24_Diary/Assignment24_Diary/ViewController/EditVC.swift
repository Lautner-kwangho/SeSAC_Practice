//
//  EditVC.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/08.
//

import UIKit
import RealmSwift

class EditVC: UIViewController {
      
    static let identifier = "EditVC"
    let localRealm = try! Realm()
    var tasks: Results<DiaryRealm>!
    var editTasks: DiaryRealm?
    
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editTitle: UITextView!
    @IBOutlet weak var editContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editView.clipsToBounds = true
        editView.layer.cornerRadius = editView.frame.size.height * 0.08
        
        editTitle.text = editTasks?.diaryTitle
        editContent.text = editTasks?.diaryContent
        
        tasks = localRealm.objects(DiaryRealm.self)
    }

    @IBAction func dismissAction(_ sender: UIButton) {
        try! localRealm.write {
            editTasks?.diaryTitle = editTitle.text
            editTasks?.diaryContent = editContent.text
        }
        self.dismiss(animated: true, completion: nil)
    }
}
