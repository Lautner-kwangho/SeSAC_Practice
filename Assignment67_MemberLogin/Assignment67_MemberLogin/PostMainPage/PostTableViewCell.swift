//
//  PostTableViewCell.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/04.
//

import UIKit

// 중간에 Xcode 업데이트 해버려서 되던 것도 안되는 버그..
class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    
    func cellConfigure(_ cell: UITableViewCell, _ indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
