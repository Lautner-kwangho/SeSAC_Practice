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
    @IBOutlet weak var btnMark: UIButton!
    @IBOutlet weak var lblList: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        cellView.layer.cornerRadius = 15
        cellView.backgroundColor = #colorLiteral(red: 0.2528861165, green: 0.5798728466, blue: 0.4502484202, alpha: 1)
        
        lblList.textColor = .white
        
        buttonSetting(btnMark, imageName: "checkmark.square")
        buttonSetting(btnStar, imageName: "star")
    }
    
    func buttonSetting(_ btn: UIButton, imageName: String) {
        btn.setImage(UIImage(systemName: imageName), for: .normal)
        btn.setTitle("", for: .normal)
        btn.tintColor = .white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        contentView.frame = contentView.bounds.inset(by: UIEdgeInsets(top: 2, left: 20, bottom: 2, right: 20))
        backgroundColor = #colorLiteral(red: 0.5416610837, green: 0.7107171416, blue: 0.7037462592, alpha: 1)
    }
}
