//
//  PostDetailTableHeaderView.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/05.
//

import UIKit

class PostDetailTableHeaderView: UITableViewCell {
    
    // 시간없어서 이미지랑 예쁘게는 시간되면 ㅜㅜ
    let userImage = UIImageView().then {
        $0.image = UIImage(systemName: "person.circle")
        $0.layer.cornerRadius = 15
        $0.tintColor = .systemGray5
    }
    let name = UILabel().then {
        $0.adjustsFontSizeToFitWidth = false
    }
    let comment = UILabel().then {
        $0.numberOfLines = 0
    }
    let commentCount = UILabel()
    
    func cellConfigure(_ cell: UITableViewCell, _ indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(userImage)
        userImage.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.width.height.equalTo(30)
        }
        
        addSubview(name)
        name.snp.makeConstraints {
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.centerY.equalTo(userImage)
            $0.leading.equalTo(userImage.snp.trailing).offset(10)
        }
        
        addSubview(comment)
        comment.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(20)
            $0.leading.equalTo(userImage)
            $0.trailing.equalTo(name)
        }
        
        addSubview(commentCount)
        commentCount.snp.makeConstraints {
            $0.top.equalTo(comment.snp.bottom).offset(20)
            $0.leading.equalTo(userImage)
            $0.trailing.equalTo(name)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
    
}
