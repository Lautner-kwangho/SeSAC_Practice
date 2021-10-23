//
//  BookCollectionVC.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/20.
//

import UIKit
import SwiftUI
import Toast

class BookCollectionVC: UIViewController {

    @IBOutlet weak var BookCollectionView: UICollectionView!
    
    let tvImfomation = TvShowInfomation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        BookCollectionView.register(nibName, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        BookCollectionView.delegate = self
        BookCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 40
        let width = UIScreen.main.bounds.width - spacing
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = spacing
        BookCollectionView.collectionViewLayout = layout
    }
    
    @objc func clickedBookCell(selectButton: UIButton) {
        // 재미삼아 넣어본 거 
        let numv = selectButton.tag * 124018
        self.view.makeToast("\(numv) 초 뒤에 이미지가 활성화 됩니다^^", duration: 1.0, position: .bottom)
        self.view.makeToastActivity(.center)
    }
    

}
extension BookCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvImfomation.tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        let tv = tvImfomation.tvShow[indexPath.row]
        
        let r : CGFloat = CGFloat.random(in: 0...0.7)
        let g : CGFloat = CGFloat.random(in: 0...0.7)
        let b : CGFloat = CGFloat.random(in: 0...0.7)
        
        cell.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        cell.layer.cornerRadius = cell.frame.size.height / 8
        cell.bookButton.tag = indexPath.item
        
        cell.bookTitle.text = tv.title
        cell.bookTitle.adjustsFontSizeToFitWidth = true
        cell.bookImage.image = UIImage(named: "\(tv.title.replacingOccurrences(of: " ", with: "_").lowercased())")
        cell.bookRate.text = "\(tv.rate)"
        cell.bookButton.setTitle("", for: .normal)
        cell.bookButton.addTarget(self, action: #selector(clickedBookCell(selectButton:)), for: .touchUpInside)
        return cell
    }

}
