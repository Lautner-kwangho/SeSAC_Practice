//
//  SearchTableViewCell.swift
//  Assignment24_Diary
//
//  Created by 최광호 on 2021/11/01.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"
    
    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var SearchDate: UILabel!
    @IBOutlet weak var searchContent: UILabel!
    @IBOutlet weak var searchImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        searchTitle.font = UIFont().mainFont
        
        SearchDate.font = UIFont.systemFont(ofSize: 12)
        
        searchContent.font = UIFont.systemFont(ofSize: 14)
        searchContent.textColor = .systemGray2
        
        searchImage.layer.cornerRadius = searchImage.frame.size.height * 0.2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
