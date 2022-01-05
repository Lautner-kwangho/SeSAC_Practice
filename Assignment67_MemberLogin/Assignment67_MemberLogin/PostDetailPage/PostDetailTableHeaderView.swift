//
//  PostDetailTableHeaderView.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/05.
//

import UIKit

class PostDetailTableHeaderView: UITableViewCell {
    
    // 시간없어서 이미지랑 예쁘게는 시간되면 ㅜㅜ
    let name = UILabel().then {
        $0.adjustsFontSizeToFitWidth = false
    }
    let comment = UILabel().then {
        $0.numberOfLines = 0
    }
    let commentCount = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(name)
        name.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        addSubview(comment)
        comment.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(name)
        }
        
        addSubview(commentCount)
        commentCount.snp.makeConstraints {
            $0.top.equalTo(comment.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(name)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
    
}
