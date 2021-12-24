//
//  StretchyTableHeaderView.swift
//  Assignment59_RandomBeer
//
//  Created by 최광호 on 2021/12/24.
//

// 예제 출처 : https://johncodeos.com/how-to-make-a-stretchy-header-in-ios-using-swift/#tableview

import UIKit
/*
 1. Headerview에 들어갈 CustomView 를 만들어준다
 
 2. 방식은 뷰에 이미지 뷰를 추가하여 구현
 2-1. 변수는 이미지뷰의 높이, 바닥, 뷰의 높이 수치 준비
 
 3-1. customView는 뷰 너비, 높이, centerX 같게 구성
 3-2. 뷰의 너비는 이미지뷰의 너비, 뷰의 높이(변수)는 CustomView의 높이로 같게
 3-3. 이미지뷰의 바닥(변수)은 뷰의 바닥, 이미지뷰의 높이(변수)는 뷰의 높이랑 같게
 
 4. 스크롤시 함수생성 NSLayoutConstraint():
  - 뷰높이의 제약 조건 = 스크롤 뷰의 UIEdge? 수치에서 top (근데 0 아닌가..)-> 상단에 고정하기 위해서
  - Y = -(스크롤 시 y + 스크롤 top)
  - 뷰의 바운스 = Y이 0보다 작을 때 원래대로 돌아옴
  - 이미지바닥 제약 조건 = Y가 0보다 크면 0 이고 아니면 y를 2로 나눠줌(음수) -> 스크롤 시 위로 올려주는 조건(위치)
  - 이미지높이 제약 조건 = Max(Y+top랑 top)중에 -> 아래로 스크롤 시 이미지 확대
 */

class StretchyTableHeaderView: UIView {
    var imageViewHeight = NSLayoutConstraint()
    var imageViewBottom = NSLayoutConstraint()
    
    var containerView: UIView!
    var imageView: UIImageView!
    
    var containerViewHeight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        
        setViewConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createViews() {
        // Container View
        containerView = UIView()
        self.addSubview(containerView)
        
        // ImageView for background
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)
    }
    
    func setViewConstraints() {
        // UIView Constraints
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            self.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        // Container View Constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        // ImageView Constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
