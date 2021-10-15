//
//  ShoppingTableViewCell.swift
//  SeSACAssignment11
//
//  Created by 최광호 on 2021/10/13.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {

    static let shoppingIdentifier = "ShoppingTableViewCell"
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var btnChecklist: UIButton!
    @IBOutlet weak var lblList: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    
    //UserDefaults - 그림을 어떻게 할지 생각다시 해보기
    var btnNumberCount = [BtnCount]()
    
    // 나중에 배열로 바꿔보자
    var markCount = 0
    var selectMark = 0
    var starCount = 0
    var selectStar = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        // ViewDidLoad <-- 사이에서 실행 -->ViewWillAppear
        // set view
        cellView.layer.cornerRadius = 15
        cellView.backgroundColor = #colorLiteral(red: 0.2528861165, green: 0.5798728466, blue: 0.4502484202, alpha: 1)
        
        lblList.textColor = .white
        
        setBtn(btnChecklist, imageName: "checkmark.square")
        setBtn(btnStar, imageName: "star")
        
        btnChecklist.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        btnStar.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        
        loadNumberData()
    }
    
    func setBtn(_ btn: UIButton, imageName: String) {
        btn.setImage(UIImage(systemName: imageName), for: .normal)
        btn.setTitle("", for: .normal)
        btn.tintColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        contentView.frame = contentView.bounds.inset(by: UIEdgeInsets(top: 2, left: 20, bottom: 2, right: 20))
        backgroundColor = #colorLiteral(red: 0.5416610837, green: 0.7107171416, blue: 0.7037462592, alpha: 1)
    }
    
    @objc func btnClicked() {
        if btnChecklist.isTouchInside == true {
            markCount += 1
            selectMark = markCount % 2
            
            let mark = selectMark == 1 ? "checkmark.square.fill" : "checkmark.square"
            btnChecklist.setImage(UIImage(systemName: mark), for: .normal)
        } else if btnStar.isTouchInside == true {
            starCount += 1
            selectStar = starCount % 2
            
            let star = selectStar == 1 ? "star.fill" : "star"
            btnStar.setImage(UIImage(systemName: star), for: .normal)
        }
        
        btnNumberCount.append(BtnCount(checkBox: selectMark, favorite: selectStar))
        // UserDeafaults
        var btnCount: [[String: Any]] = []
        
        for count in btnNumberCount {
            let numberData: [String: Int] = [
                "checkBox": count.checkBox,
                "favorite": count.favorite
            ]
            btnCount.append(numberData)
        }
        UserDefaults.standard.set(btnCount, forKey: "btnCount")
    }
    
    func loadNumberData() {
        let ud = UserDefaults.standard
        if let btnData = ud.object(forKey: "btnCount") as? [[String: Int]] {
            var btnCount = [BtnCount]()
            for datum in btnData {
                guard let checkBox = datum["checkBox"] else {return}
                guard let favorite = datum["favorite"] else {return}
                btnCount.append(BtnCount(checkBox: checkBox, favorite: favorite))
            }
            self.btnNumberCount = btnCount
        }
    }
}
