//
//  StretchyTableHeaderView.swift
//  Assignment59_RandomBeer
//
//  Created by 최광호 on 2021/12/21.
//

import UIKit

// 음 유튜브는 이상한 듯 ... ㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜ 따라적었는데 아까워서 냅둔다 ㅡㅡ


class Youtube: UIView {
    
    let containerView = UIView()
    
    let imageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleToFill
    }
    
    var imageViewHeight = NSLayoutConstraint()
    var imageViewBottom = NSLayoutConstraint()
    var containerViewHeight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createView()
        setViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView() {
        addSubview(containerView)
        containerView.addSubview(imageView)
    }
    
    func setViewConstraints() {
        self.snp.makeConstraints { make in
            make.width.centerX.height.equalTo(containerView)
        }
        containerView.snp.makeConstraints { make in
            make.width.equalTo(imageView)
        }
        
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
