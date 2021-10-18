//
//  MainTableViewCell.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/16.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    static let identifier = "MainTableViewCell"
    
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var posterRate: UILabel!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var posterRelase: UILabel!
    @IBOutlet weak var btnOtherContent: UIButton!
    
    @IBOutlet weak var linkTvShow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgPoster.contentMode = .scaleToFill
        
        lblTag.grayFontSetting()
        lblName.fontSetting(size: 20)
        posterName.fontSetting(size: 25)
        posterRelase.grayFontSetting()
        btnOtherContent.tintColor = .black
        
        // extension이 왜 안되지;
        linkTvShow.setImage(UIImage(systemName: "paperclip.circle.fill"), for: .normal)
        linkTvShow.setTitle("", for: .normal)
        linkTvShow.tintColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UILabel {
    func grayFontSetting() {
        self.font = UIFont.systemFont(ofSize: 14)
        self.textColor = .systemGray3
    }
    
    func fontSetting(size: CGFloat) {
        self.font = UIFont.boldSystemFont(ofSize: size)
    }
}
