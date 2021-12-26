//
//  DetailDramaCell.swift
//  Assignment60_Drama
//
//  Created by 최광호 on 2021/12/27.
//

import UIKit

class DetailDramaCell: UITableViewCell {
    
    let posterImage = UIImageView().then {
        $0.backgroundColor = .gray
    }
    let title = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .white
        $0.adjustsFontSizeToFitWidth = true
    }
    let date = UILabel().then {
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .systemGray4
    }
    let content = UILabel().then {
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .systemGray4
        $0.numberOfLines = 3
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        [posterImage, title, date, content].forEach {
            addSubview($0)
        }

        posterImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(posterImage.snp.height).multipliedBy(0.7)
        }
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(posterImage.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(30)
        }
        
        date.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(title)
            $0.height.equalTo(title)
        }
        
        content.snp.makeConstraints {
            $0.top.equalTo(date.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(title)
            $0.bottom.equalToSuperview().inset(5)
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
