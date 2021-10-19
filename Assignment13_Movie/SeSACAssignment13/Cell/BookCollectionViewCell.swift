//
//  BookCollectionViewCell.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/20.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    static let identifier = "BookCollectionViewCell"
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookRate: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bookTitle.font = UIFont.boldSystemFont(ofSize: 20)
        bookTitle.textColor = .white
        bookRate.grayFontSetting()
    }

}
