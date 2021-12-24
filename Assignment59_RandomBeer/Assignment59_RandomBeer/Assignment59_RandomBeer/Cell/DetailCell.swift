//
//  DetailCell.swift
//  Assignment59_RandomBeer
//
//  Created by 최광호 on 2021/12/21.
//

import UIKit

class DetailCell: UITableViewCell {

    static let identifier = "DetailCell"
    
    let autoView = UIView().then {
        $0.backgroundColor = .brown
    }
    
    let title = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 30)
        $0.sizeToFit()
        $0.adjustsFontSizeToFitWidth = true
        $0.textAlignment = .center
    }
    let subTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
        $0.adjustsFontSizeToFitWidth = true
        $0.textAlignment = .center
    }
    let content = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
        $0.numberOfLines = 3
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(autoView)
        autoView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        [title, subTitle, content].forEach {
            autoView.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
            }
        }
        title.snp.makeConstraints {
            $0.leading.trailing.equalTo(self).inset(20)
        }
        subTitle.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(self).inset(20)
        }
        content.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(self).inset(20)
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
