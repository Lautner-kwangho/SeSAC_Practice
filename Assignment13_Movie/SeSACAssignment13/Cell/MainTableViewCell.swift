//
//  MainTableViewCell.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/16.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    static let identifier = "MainTableViewCell"
    
    @IBOutlet weak var trendRelease: UILabel!
    @IBOutlet weak var trendGenre: UILabel!
    
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var trendRate: UILabel!
    @IBOutlet weak var trendName: UILabel!
    @IBOutlet weak var trendOverview: UILabel!
    @IBOutlet weak var btnOtherView: UIView!
    @IBOutlet weak var btnOtherContent: UIButton!
    
    @IBOutlet weak var linkTvShow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterView.layer.cornerRadius = posterView.frame.size.width * 0.05
        posterView.backgroundColor = .systemGray6
        posterView.clipsToBounds = true
        imgPoster.contentMode = .scaleAspectFill
        
        trendRelease.grayFontSetting()
        trendGenre.fontSetting(size: 20)
        trendName.fontSetting(size: 25)
        trendOverview.grayFontSetting()
        btnOtherContent.tintColor = .black
        btnOtherView.layer.addBorder([.top], color: .gray, width: 1)
        
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

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
