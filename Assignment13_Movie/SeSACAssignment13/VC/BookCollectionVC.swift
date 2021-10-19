//
//  BookCollectionVC.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/20.
//

import UIKit
import SwiftUI

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
        
        cell.bookTitle.text = tv.title
        cell.bookImage.image = UIImage(named: "\(tv.title.replacingOccurrences(of: " ", with: "_").lowercased())")
        cell.bookRate.text = "\(tv.rate)"
        
        return cell
    }
    
    
}
