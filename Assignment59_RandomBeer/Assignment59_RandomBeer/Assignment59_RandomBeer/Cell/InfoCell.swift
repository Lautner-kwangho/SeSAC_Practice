//
//  InfoCell.swift
//  Assignment59_RandomBeer
//
//  Created by 최광호 on 2021/12/21.
//

import UIKit

class InfoCell: UITableViewCell {

    static let identifier = "InfoCell"
    
    let paringLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(paringLabel)
        
        paringLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
