//
//  SectionTableViewCell.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/19.
//

import UIKit

class SectionTableViewCell: UITableViewCell {

    static let identifier = "SectionTableViewCell"
    
    @IBOutlet weak var sectionTextView: UILabel!
    @IBOutlet weak var autoDimensionButton: UIButton!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sectionTextView.font = UIFont.systemFont(ofSize: 18, weight: .light)
        sectionTextView.numberOfLines = 0
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
