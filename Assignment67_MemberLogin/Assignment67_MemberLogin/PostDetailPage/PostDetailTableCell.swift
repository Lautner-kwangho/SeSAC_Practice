//
//  PostDetailTableCell.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/05.
//

import UIKit

class PostDetailTableCell: UITableViewCell {
    
    let name = UILabel().then {
        $0.adjustsFontSizeToFitWidth = true
    }
    let comment = UILabel().then {
        $0.sizeToFit()
        $0.numberOfLines = 0
    }
    let button = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
    }
    
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
        addSubview(name)
        name.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        addSubview(comment)
        comment.snp.makeConstraints {
            $0.leading.trailing.equalTo(name)
            $0.top.equalTo(name.snp.bottom).offset(10)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        addSubview(button)
        button.snp.makeConstraints {
            $0.top.equalTo(name)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.width.height.equalTo(20)
        }
    }
    
}
