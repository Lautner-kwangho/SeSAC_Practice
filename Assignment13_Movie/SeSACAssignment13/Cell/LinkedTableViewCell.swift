//
//  LinkedTableViewCell.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/31.
//

import UIKit
import WebKit

// import AVKit <- 이거 사용했는데 로딩만 되고 안되네..

class LinkedTableViewCell: UITableViewCell {
    
    static let identifier = "LinkedTableViewCell"
    
    @IBOutlet weak var linkedName: UILabel!
    @IBOutlet weak var linkedWebView: WKWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        linkedWebView.scrollView.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
