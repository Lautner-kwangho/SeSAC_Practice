//
//  DailyOfficeTableViewCell.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/27.
//

import UIKit

class DailyOfficeTableViewCell: UITableViewCell {

    static let identifier = "DailyOfficeTableViewCell"
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRelease: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = .clear
    }
    
}
