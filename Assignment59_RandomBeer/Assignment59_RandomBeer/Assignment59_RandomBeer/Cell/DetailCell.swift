//
//  DetailCell.swift
//  Assignment59_RandomBeer
//
//  Created by 최광호 on 2021/12/21.
//

import UIKit

class DetailCell: UITableViewCell {

    static let identifier = "DetailCell"
    
    let title = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
    }
    let subTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
    }
    let content = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        [title, subTitle, content].forEach {
            addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
            }
            $0.sizeToFit()
        }
        subTitle.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(20)
        }
        content.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
